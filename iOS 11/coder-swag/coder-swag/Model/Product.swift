//
//  Product.swift
//  coder-swag
//
//  Created by robot on 4/28/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

struct Product {
    private(set) public var title: String
    private(set) public var price: String
    private(set) public var imageName: String
    
    init(title: String, price: String, imageName: String) {
        self.title = title
        self.price = price
        self.imageName = imageName
    }
}
