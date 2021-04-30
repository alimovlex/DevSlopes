//
//  Wage.swift
//  window-shopper
//
//  Created by robot on 4/27/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation
class Wage {
    class func getHours(forWage wage: Double, andPrice price: Double) -> Int {
       return Int(ceil(price/wage));
    }
}
