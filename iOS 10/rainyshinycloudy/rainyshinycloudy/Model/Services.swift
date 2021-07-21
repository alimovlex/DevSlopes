//
//  Services.swift
//  rainyshinycloudy
//
//  Created by robot on 3/27/21.
//  Copyright © 2021 robot. All rights reserved.
//

import CoreLocation

class Services {
    
    static var sharedInstance = Services();
    private init() {
        
    }
    
    var latitude: Double?;
    var longtitude: Double?;

    func checkInternetConnection() -> Bool {
            if Connectivity.isConnectedToInternet {
                print("Connected");
                return true;
             } else {
                print("No Internet");
                return false;
            }
        }
    
}
