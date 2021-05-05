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
    
    var goalType: GoalType = .shortTerm;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        bindCustomBtnToKeyboard();
        nextBtn.bindToKeyboard();
        shortTermBtn.setSelectedColor();
        longTermBtn.setDeselectedColor();
    }
    
    func bindCustomBtnToKeyboard() {
        let nxtBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60));
        nxtBtn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1);
        nxtBtn.setTitle("NEXT", for: .normal);
        nxtBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal);
        nxtBtn.addTarget(self, action: #selector(CreateGoalVC.calculate), for: .touchUpInside);
        goalTextView.inputAccessoryView = nxtBtn;
    }
    
    @objc func calculate() {
        print("NEXT button was pressed");
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail(); //Custom UINavigationController dismissal
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm;
        shortTermBtn.setDeselectedColor();
        longTermBtn.setSelectedColor();
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm;
        shortTermBtn.setSelectedColor();
        longTermBtn.setDeselectedColor();
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        
    }
    
}
