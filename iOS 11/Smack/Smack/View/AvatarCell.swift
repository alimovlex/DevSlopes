//
//  AvatarCell.swift
//  Smack
//
//  Created by robot on 6/14/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        setUpView();
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)");
            self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1);
        } else {
            avatarImg.image = UIImage(named: "light\(index)");
            self.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1);
        }
    }
    
    func setUpView() {
        self.layer.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1);
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true;
    }
    
    
    
    
    
}
