//
//  MapVC.swift
//  pixel-city
//
//  Created by robot on 4/30/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
    }
    
    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
        
    }
}

extension MapVC: MKMapViewDelegate {
    
}

