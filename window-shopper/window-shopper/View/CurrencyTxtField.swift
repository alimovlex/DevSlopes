//
//  CurrencyTxtField.swift
//  window-shopper
//
//  Created by robot on 4/27/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class CurrencyTxtField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib();
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25);
        layer.cornerRadius = 5.0;
        textAlignment = .center;
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]);
            attributedPlaceholder = place;
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        }
    }
    
}
