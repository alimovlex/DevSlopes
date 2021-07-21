//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by robot on 3/15/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    @IBOutlet weak var dateLabel: UILabel!;
    
    @IBOutlet weak var currentTempLabel: UILabel!;
    
    @IBOutlet weak var locationLabel: UILabel!;
    
    @IBOutlet weak var currentWeatherImage: UIImageView!;
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!;
    
    @IBOutlet weak var tableView: UITableView!;
    
    let locationManager = CLLocationManager();
    var currentLocation: CLLocation!;
    
    var currentWeather: CurrentWeather!;
    var forecast: Forecast!;
    var forecasts = [Forecast]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startMonitoringSignificantLocationChanges();
        tableView.delegate = self;
        tableView.dataSource = self;
        currentWeather = CurrentWeather();
        //forecast = Forecast();
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Services.sharedInstance.checkInternetConnection() {
            locationAuthStatus();
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI();
            }
        }
        } else {
            let alertController = UIAlertController(title: "Please enable wifi connection in the settings menu.", message: "The internet connection is required.", preferredStyle: .alert);
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "App-Prefs:root=WIFI")!)
                } else {
                    let settingsUrl = URL(string: "App-Prefs:root=WIFI")
                    if let url = settingsUrl {
                        UIApplication.shared.openURL(url);
                    } else {
                        print("incorrect URL provided!");
                    }
                }
                }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel); //dismissing the entrance of the URL
            
            alertController.addAction(settingsAction) //connect the submit button the UIAlertController
            alertController.addAction(cancelAction) //connect the cancel button the UIAlertController
            
            present(alertController, animated: true) //showing the URL entrance message
        }
        
    }
    
    func locationAuthStatus() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in //thread added
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self?.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self?.currentLocation = self?.locationManager.location;
            Services.sharedInstance.latitude = self?.currentLocation.coordinate.latitude;
            Services.sharedInstance.longtitude = self?.currentLocation.coordinate.longitude;
        } else {
            self?.locationManager.requestWhenInUseAuthorization();
            self?.locationAuthStatus();
            }
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        //let forecastURL = URL(string: FORECAST_URL);
        DispatchQueue.global(qos: .background).async { [weak self] in //thread added
        Alamofire.request(forecastWeatherUrl()).responseJSON { response in
            let result = response.result;
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj);
                        self?.forecasts.append(forecast);
                        print(obj);
                    }
                    self?.forecasts.remove(at: 0);
                    self?.tableView.reloadData();
                }
            }
            completed();
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row];
            cell.configureCell(forecast: forecast);
            return cell;
        } else {
            return WeatherCell();
        }
    }

    func updateMainUI() {
        dateLabel.text = currentWeather.date;
        currentTempLabel.text = String(currentWeather.currentTemp.rounded());
       locationLabel.text = currentWeather.cityName;
        currentWeatherTypeLabel.text = currentWeather.weatherType;
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType);
    }
    
}

