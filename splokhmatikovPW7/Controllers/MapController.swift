//
//  ViewController.swift
//  splokhmatikovPW7
//
//  Created by Sergey Lokhmatikov on 30.01.2022.
//

import UIKit
import YandexMapsMobile

class MapController: UIViewController, UITextFieldDelegate {
    let buttonsStackView = UIStackView()
    
    var isActive = false
    
    let textStack = UIStackView()
    
    let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    
    let startLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.lightGray
        control.textColor = UIColor.black
        control.placeholder = "From"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode =
        UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment =
        UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    let stopLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.lightGray
        control.textColor = UIColor.black
        control.placeholder = "To"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode =
        UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment =
        UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    let goButton = ActionButton(color: #colorLiteral(red: 241.0/255.0, green: 1,blue: 191.0/255.0, alpha: 1), text: "Go")
    let clearButton = ActionButton(color: #colorLiteral(red: 0.5582880378, green: 1, blue: 1, alpha: 1), text: "Clear")
    
    private let mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.clipsToBounds = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        return mapView
    }()
    
    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
    }
    
    private func configureUI() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.addSubview(mapView)
        textStack.axis = .vertical
        view.addSubview(textStack)
        textStack.spacing = 10
        textStack.pin(to: view, [.top: 50, .left: 10, .right: 10])
        [startLocation, stopLocation].forEach { textField in
            textField.setHeight(to: 40)
            textField.delegate = self
            textStack.addArrangedSubview(textField)
        }
        startLocation.addTarget(self, action: #selector(changedText), for: .allEditingEvents)
        stopLocation.addTarget(self, action: #selector(changedText), for: .allEditingEvents)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: 0
        ).isActive = true
        mapView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 0
        ).isActive = true
        mapView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 0
        ).isActive = true
        mapView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 0
        ).isActive = true
        configureButtons()
    }
    
    func configureButtons(){
        goButton.isEnabled = isActive
        clearButton.isEnabled = isActive
        clearButton.setTitleColor(.gray, for: .disabled)
        goButton.setTitleColor(.gray, for: .disabled)
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        buttonsStackView.addArrangedSubview(goButton)
        buttonsStackView.addArrangedSubview(clearButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.addTarget(self, action: #selector(clearButtonWasPressed), for: .touchDown)
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -10
        ).isActive = true
        buttonsStackView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 10
        ).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        buttonsStackView.topAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -100
        ).isActive = true
        buttonsStackView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -30
        ).isActive = true
    }
    
    @objc func dismissKeyboard(){
        startLocation.endEditing(true)
        stopLocation.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        if isActive {
            goButtonWasPressed()
        }
        return true
    }
    
    @objc func clearButtonWasPressed(){
        startLocation.text = ""
        stopLocation.text = ""
        clearButton.setTitleColor(.gray, for: .disabled)
        clearButton.isEnabled = false
        goButton.setTitleColor(.gray, for: .disabled)
        goButton.isEnabled = false
        isActive = false
    }
    
    
    
    @objc func goButtonWasPressed(){
        guard
            let first = startLocation.text,
            let second = stopLocation.text,
            first != second
        else {
            return
        }
    }
    
    @objc func changedText(){
        if startLocation.text == "" || stopLocation.text == ""{
            isActive = false
            clearButton.setTitleColor(.gray, for: .disabled)
            clearButton.isEnabled = false
            goButton.setTitleColor(.gray, for: .disabled)
            goButton.isEnabled = false
        } else {
            isActive = true
            clearButton.setTitleColor(.black, for: .normal)
            clearButton.isEnabled = true
            goButton.setTitleColor(.black, for: .normal)
            goButton.isEnabled = true
        }
    }
}
