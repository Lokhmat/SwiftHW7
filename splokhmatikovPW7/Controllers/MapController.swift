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
    
    let textStack = UIStackView()
    
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
        let goButton = ActionButton(color: #colorLiteral(red: 241.0/255.0, green: 1,blue: 191.0/255.0, alpha: 1), text: "Go")
        let clearButton = ActionButton(color: #colorLiteral(red: 0.5582880378, green: 1, blue: 1, alpha: 1), text: "Clear")
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        buttonsStackView.addArrangedSubview(goButton)
        buttonsStackView.addArrangedSubview(clearButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
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
        return true
    }
}
