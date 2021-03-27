//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by robot on 3/15/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var dateLabel: UILabel!;
    
    @IBOutlet weak var currentTempLabel: UILabel!;
    
    @IBOutlet weak var locationLabel: UILabel!;
    
    @IBOutlet weak var currentWeatherImage: UIImageView!;
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!;
    
    @IBOutlet weak var tableView: UITableView!;
    
    var currentWeather: CurrentWeather!;
    var forecast: Forecast!;
    var forecasts = [Forecast]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        tableView.delegate = self;
        tableView.dataSource = self;
        currentWeather = CurrentWeather();
        //forecast = Forecast();
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI();
            }
            
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        //let forecastURL = URL(string: FORECAST_URL);
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result;
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj);
                        self.forecasts.append(forecast);
                        print(obj);
                    }
                    self.forecasts.remove(at: 0);
                    self.tableView.reloadData();
                }
            }
            completed();
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
        currentTempLabel.text = "\(currentWeather.currentTemp.rounded())";
       locationLabel.text = currentWeather.cityName;
        currentWeatherTypeLabel.text = currentWeather.weatherType;
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType);
    }
}

