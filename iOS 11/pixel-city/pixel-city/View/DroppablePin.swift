//
//  DroppablePin.swift
//  pixel-city
//
//  Created by robot on 5/2/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D;
    var identifier: String;
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate;
        self.identifier = identifier;
        super.init();
    }
}
