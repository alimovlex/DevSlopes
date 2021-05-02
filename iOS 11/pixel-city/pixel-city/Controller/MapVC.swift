//
//  MapVC.swift
//  pixel-city
//
//  Created by robot on 4/30/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!;
    
    var locationManager = CLLocationManager();
    let authorizationStatus = CLLocationManager.authorizationStatus();
    let regionRadius: Double = 500;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        locationManager.delegate = self;
        configureLocationServices();
        addDoubleTap();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.startUpdatingLocation();
        print(self.deviceLocation());
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)));
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delegate = self;
        mapView.addGestureRecognizer(doubleTap);
    }
    
    func deviceLocation() ->String {
        return "Longtitude: \(self.locationManager.location!.coordinate.longitude) Latitude: \(self.locationManager.location!.coordinate.latitude)"
    }
    
    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation();
        }
    }
    
}

extension MapVC: MKMapViewDelegate {
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius);
        mapView.setRegion(coordinateRegion, animated: true);
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        removePin();
        let touchPoint = sender.location(in: mapView);
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView);
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin");
        mapView.addAnnotation(annotation);
        
        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius);
        mapView.setRegion(coordinateRegion, animated: true);
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation);
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization();
            locationManager.startUpdatingLocation();
        } else {
            return;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation();
    }
}
