//
//  ViewController.swift
//  splokhmatikovPW7
//
//  Created by Sergey Lokhmatikov on 30.01.2022.
//

import UIKit
import YandexMapsMobile

class MapController: UIViewController {

    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private let mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.clipsToBounds = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }

}

