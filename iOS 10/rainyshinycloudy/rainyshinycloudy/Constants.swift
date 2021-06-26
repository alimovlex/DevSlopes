//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by robot on 3/22/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?";
let LATITUDE = "lat=";
let LONGTITUDE = "&lon=";
let APP_ID = "&appid=";
let API_KEY = "dd901d59fd590a54f070075a96812a94";
            
let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?";
let DAYS_COUNT = "&cnt=16";
typealias DownloadComplete = () -> ();

func forecastWeatherUrl () -> String {
    
    if let latitude = Location.sharedInstance.latitude, let longtitude = Location.sharedInstance.longtitude {
        return "\(FORECAST_BASE_URL)\(LATITUDE)\(latitude)\(LONGTITUDE)\(longtitude)\(DAYS_COUNT)\(APP_ID)\(API_KEY)"
    } else {
        return "";
    }
}

func currentWeatherUrl () -> String {
    
    if let latitude = Location.sharedInstance.latitude, let longtitude = Location.sharedInstance.longtitude {
        return "\(BASE_URL)\(LATITUDE)\(latitude)\(LONGTITUDE)\(longtitude)\(APP_ID)\(API_KEY)";
    } else {
        return "";
    }
}
//let stroka = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=52&lon=86&cnt=10&appid=542ffd081e67f4512b705f89d2a611b2";

