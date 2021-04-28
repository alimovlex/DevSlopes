//
//  CircleButton.swift
//  Scribe
//  Making the custom circle button
//  Created by robot on 4/29/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView();
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView();
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius;
    }

}
