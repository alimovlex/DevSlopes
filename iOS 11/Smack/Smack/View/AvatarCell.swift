//
//  AvatarCell.swift
//  Smack
//
//  Created by robot on 6/14/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        setUpView();
    }
    
    func setUpView() {
        self.layer.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1);
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true;
    }
    
    
    
    
    
}
