//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {

    @IBOutlet weak var pointsTextField: UITextField!;
    
    var goalDescription: String!;
    var goalType: GoalType!;
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description;
        self.goalType = type;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        bindCreateGoalBtnToKeyboard();
    }
    
    func bindCreateGoalBtnToKeyboard() {
        let createGoalBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50));
        createGoalBtn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1);
        createGoalBtn.setTitle("CREATE GOAL", for: .normal);
        createGoalBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal);
        createGoalBtn.addTarget(self, action: #selector(FinishGoalVC.createGoalBtnWasPressed), for: .touchUpInside);
        pointsTextField.inputAccessoryView = createGoalBtn;
    }
    
    @objc func createGoalBtnWasPressed() {
        //Pass data into Core Data Goal Model
        print("CREATE GOAL button was pressed");
    }
}
