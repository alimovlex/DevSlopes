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
            print(response);
        }
        completed();
    }
    
}
