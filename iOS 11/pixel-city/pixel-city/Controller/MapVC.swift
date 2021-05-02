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
import Alamofire
import AlamofireImage

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!;
    @IBOutlet weak var pullUpView: UIView!;
    @IBOutlet weak var pullUpViewHeightConstraint: NSLayoutConstraint!;
    
    var locationManager = CLLocationManager();
    let authorizationStatus = CLLocationManager.authorizationStatus();
    let regionRadius: Double = 500;
    var screenSize = UIScreen.main.bounds;
    
    var spinner: UIActivityIndicatorView?;
    var progressLbl: UILabel?;
    
    var flowLayout = UICollectionViewFlowLayout();
    var collectionView: UICollectionView?;
    
    var imageUrlArray = [String]();
    var imageArray = [UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        locationManager.delegate = self;
        configureLocationServices();
        addDoubleTap();
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout);
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell");
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        
        pullUpView.addSubview(collectionView!);
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)));
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delegate = self;
        mapView.addGestureRecognizer(doubleTap);
    }
    
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown));
        swipe.direction = .down;
        pullUpView.addGestureRecognizer(swipe);
    }
    
    func animateViewUp() {
        pullUpViewHeightConstraint.constant = 150;
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded();
        }
    }
    
   @objc func animateViewDown() {
        cancelAllSessions();
        pullUpViewHeightConstraint.constant = 0;
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded();
        }
    }
    
    func addSpinner() {
        spinner = UIActivityIndicatorView();
        spinner?.center = CGPoint(x: (screenSize.width/2) - ((spinner?.frame.width)!/2), y: 75);
        spinner?.style = .whiteLarge;
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1);
        spinner?.startAnimating();
        collectionView?.addSubview(spinner!);
    }
    
    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview();
        }
    }
    
    func addProgressLbl() {
        progressLbl = UILabel();
        progressLbl?.frame = CGRect(x: (screenSize.width/2) - 120, y: 100, width: 240, height: 40);
        progressLbl?.font = UIFont(name: "Avenir Next", size: 14);
        progressLbl?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1);
        progressLbl?.textAlignment = .center;
        collectionView?.addSubview(progressLbl!);
    }
    
    func removeProgressLbl() {
        if progressLbl != nil {
            progressLbl?.removeFromSuperview();
        }
    }
    
    @IBAction func centerMapBtnWasPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation();
        }
    }
    
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil;
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin");
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1);
        pinAnnotation.animatesDrop = true;
        return pinAnnotation;
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius);
        mapView.setRegion(coordinateRegion, animated: true);
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        removePin();
        removeSpinner();
        removeProgressLbl();
        cancelAllSessions();
        
        imageUrlArray = [];
        imageArray = [];
        
        collectionView?.reloadData();
        
        animateViewUp();
        addSwipe();
        addSpinner();
        addProgressLbl();
        
        let touchPoint = sender.location(in: mapView);
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView);
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin");
        mapView.addAnnotation(annotation);
        
        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius);
        mapView.setRegion(coordinateRegion, animated: true);
        
        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                self.retrieveImages { (finished) in
                    if finished {
                        self.removeSpinner();
                        self.removeProgressLbl();
                        self.collectionView?.reloadData();
                    }
                }
            }
        }
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation);
        }
    }
    
    func retrieveUrls(forAnnotation annotation: DroppablePin, handler: @escaping (_ status: Bool) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in //thread added
        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotation, andNumberOfPhotos: 10)).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {return;}
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>;
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>];
            for photo in photosDictArray {
                let postUrl = "https://live.staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_b_d.jpg";
                self?.imageUrlArray.append(postUrl);
            }
            handler(true);
        }
        }
    }
    
    func retrieveImages(handler: @escaping (_ status: Bool) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in //thread added
            for url in self!.imageUrlArray {
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else {return;}
                self?.imageArray.append(image);
                self?.progressLbl?.text = "\(self!.imageArray.count))/10 IMAGES DOWNLOADED";
                if self?.imageArray.count == self?.imageUrlArray.count {
                    handler(true);
                }
            });
        }
        }
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({$0.cancel()});
            downloadData.forEach({$0.cancel()});
        }
    }
    
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationServices() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in //thread added
            if self?.authorizationStatus == .notDetermined {
                self?.locationManager.requestAlwaysAuthorization();
                self?.locationManager.startUpdatingLocation();
                self?.locationManager.distanceFilter = kCLDistanceFilterNone;
                self?.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                //print(self!.deviceLocation());
        } else {
            return;
        }
    }
}
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation();
    }
}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of items in array.
        return imageArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {return UICollectionViewCell()}
        let imageFromIndex = imageArray[indexPath.row];
        let imageView = UIImageView(image: imageFromIndex);
        cell.addSubview(imageView);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else {return;}
        popVC.initData(forImage: imageArray[indexPath.row]);
        present(popVC, animated: true, completion: nil);
    }
}
