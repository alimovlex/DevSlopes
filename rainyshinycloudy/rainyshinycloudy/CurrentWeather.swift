//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by robot on 3/22/21.
//  Copyright © 2021 robot. All rights reserved.
// THE MODEL OF THE APPLICATION

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!;
    var _date: String!;
    var _weatherType: String!;
    var _currentTemp: Double!;
    //var _highTemp: String!;
    var cityName: String {
        if _cityName == nil {
            _cityName = "";
        }
        return _cityName;
    }
    
    var date: String {
        if _date == nil {
            _date = "";
        }
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = .long;
        dateFormatter.timeStyle = .none;
        let currentDate = dateFormatter.string(from: Date());
        self._date = "Today, \(currentDate)";
        return _date;
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "";
        }
        return _weatherType;
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0;
        }
        return _currentTemp;
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        //Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!;
        AF.request(currentWeatherURL).responseJSON { response in
            let result = response.result;
            //if let dict = result as? Dictionary<String, AnyObject>
                switch result {
                case .success(let value):
                    let dict = value as! Dictionary<String, AnyObject>;
                    if let name = dict["name"] as? String {
                    self._cityName = name.capitalized;
                        print(name);
                    }
                    if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                        if let main = weather[0]["main"] as? String {
                            self._weatherType = main.capitalized;
                            print(main);
                        }
                    }
                    
                    if let main = dict["main"] as? Dictionary<String, AnyObject> {
                        
                        if let currentTemperature = main["temp"] as? Double {
                            let kelvinToCelsius = currentTemperature - 273.15;
                            self._currentTemp = kelvinToCelsius;
                            print(kelvinToCelsius);
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
        completed();
    }
    
}
