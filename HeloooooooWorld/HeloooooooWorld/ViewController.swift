//
//  ViewController.swift
//  HeloooooooWorld
//
//  Created by robot on 3/5/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var welcomeBtn: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    @IBAction func welcomePressed(_ sender: UIButton) {
        background.isHidden = false;
        titleImage.isHidden = false;
        welcomeBtn.isHidden = true;
        
    }
}

