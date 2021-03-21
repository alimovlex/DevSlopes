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
let API_KEY = "3869fcfd56edc3ae705f81a16899e911";

typealias DownloadComplete = () -> ();

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)52\(LONGTITUDE)86\(APP_ID)\(API_KEY)";


