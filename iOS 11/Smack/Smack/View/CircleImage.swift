//
//  CircleImage.swift
//  Smack
//
//  Created by robot on 6/14/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView();
    }
    
    func setupView() {
        
        self.layer.cornerRadius = self.frame.width / 2;
        self.clipsToBounds = true;
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder();
        setupView();
    }

}
