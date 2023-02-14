//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by alimovlex on 7/27/16.
//  Copyright © 2021 alimovlex. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Download Current Weather Data
        DispatchQueue.global(qos: .background).async { [weak self] in //thread added
        Alamofire.request(currentWeatherUrl()).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self?._cityName = name.capitalized
                    if let namecity = self?._cityName {
                        print(namecity);
                    } else {
                        print("NULL");
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self?._weatherType = main.capitalized
                        if let typeweather = self?._weatherType {
                            print(typeweather);
                        } else {
                            print("NULL");
                        }
                    }
                
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        self?._currentTemp = currentTemperature;
                        if let tempnow = self?._currentTemp {
                            print(tempnow);
                        } else {
                            print("NULL");
                        }
                    }
                }
            }
            completed();
        }
        }
    }
}













