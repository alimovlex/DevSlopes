//
//  Location.swift
//  rainyshinycloudy
//
//  Created by robot on 3/27/21.
//  Copyright © 2021 robot. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location();
    private init() {
        
    }
    
    var latitude: Double?;
    var longtitude: Double?;
    
}
