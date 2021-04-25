//
//  BorderButton.swift
//  app-swoosh
//
//  Created by robot on 4/25/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib();
        layer.borderWidth = 2.0;
        layer.borderColor = UIColor.white.cgColor;
    }

}
