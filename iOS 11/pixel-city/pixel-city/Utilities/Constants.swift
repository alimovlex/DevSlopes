//
//  Constants.swift
//  pixel-city
//
//  Created by robot on 5/2/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

let apiKey = "19bd6f6d2e5055cff812d6f43ba1035b";

func flickrUrl (forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    
   return   "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1";
    
}
