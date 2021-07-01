//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by robot on 3/27/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit;
import Alamofire;

class Forecast {
    
    var _date: String!;
    var _weatherType: String!;
    var _highTemp: String!;
    var _lowTemp: String!;
    var _time: String!;
    
    var date: String {
        if _date == nil {
            _date = "NULL";
        }
        return _date;
    }
    
    var time: String {
        if _time == nil {
            _time = "NULL";
        }
        return _time;
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "NULL";
        }
        return _weatherType;
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = "NULL";
        }
        return _highTemp;
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = "NULL";
        }
        return _lowTemp;
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["main"] {
            
            if let min = temp["temp_min"] as? Double {
                let kelvinToCelsius = min - 273.15;
                                       
                self._lowTemp = String(kelvinToCelsius.rounded());
            }
            
            if let max = temp["temp_max"] as? Double {
                let kelvinToCelsius = max - 273.15;
                                       
                self._highTemp = String(kelvinToCelsius.rounded());
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main;
                
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDay = Date(timeIntervalSince1970: date);
            let dateFormatter = DateFormatter();
            dateFormatter.dateStyle = .full;
            dateFormatter.dateFormat = "EEEE";
            dateFormatter.timeStyle = .none;
            self._date = unixConvertedDay.dayOfTheWeek();
            self._time = unixConvertedDay.timeOfTheDay();
        }
        
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "EEEE";
        return dateFormatter.string(from: self);
    }
    func timeOfTheDay() -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.timeStyle = .short;
        return dateFormatter.string(from: self);
    }
}
