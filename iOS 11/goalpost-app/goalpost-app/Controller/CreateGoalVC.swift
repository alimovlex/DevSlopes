//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!;
    
    @IBOutlet weak var shortTermBtn: UIButton!;
    
    @IBOutlet weak var longTermBtn: UIButton!;
    
    var goalType: GoalType = .shortTerm;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        bindNextBtnToKeyboard();
        shortTermBtn.setSelectedColor();
        longTermBtn.setDeselectedColor();
        goalTextView.delegate = self;
    }
    
    func bindNextBtnToKeyboard() {
        let nextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50));
        nextBtn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1);
        nextBtn.setTitle("NEXT", for: .normal);
        nextBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal);
        nextBtn.addTarget(self, action: #selector(CreateGoalVC.nextBtnWasPressed), for: .touchUpInside);
        goalTextView.inputAccessoryView = nextBtn;
    }
    
    @objc func nextBtnWasPressed() {
        if goalTextView.text != "" &&  goalTextView.text != "What is your goal?" {
        guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return;}
        finishGoalVC.initData(description: goalTextView.text!, type: goalType);
        presentDetail(finishGoalVC);
        }
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = "";
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1);
    }
    
}
