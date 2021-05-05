//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!;
    
    @IBOutlet weak var shortTermBtn: UIButton!;
    
    @IBOutlet weak var longTermBtn: UIButton!;
    
    @IBOutlet weak var nextBtn: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail();
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        
    }
    
}
