//
//  ChannelVC.swift
//  Smack
//
//  Created by robot on 4/30/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60;
    }
    
}
