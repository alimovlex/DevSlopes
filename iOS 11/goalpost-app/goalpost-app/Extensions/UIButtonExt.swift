//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1);
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1);
    }
}
