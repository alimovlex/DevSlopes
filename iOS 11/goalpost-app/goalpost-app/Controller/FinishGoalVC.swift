//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pointsTextField: UITextField!;
    
    var goalDescription: String!;
    var goalType: GoalType!;
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description;
        self.goalType = type;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        pointsTextField.delegate = self;
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
        if pointsTextField.text != "" {
        self.save { (complete) in
            if complete {
                dismiss(animated: true, completion: nil);
            }
        }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail();
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        if #available(iOS 10.0, *) {
            guard let managedContext = appDelegate?.persistentContainer.viewContext else {return;}
            let goal = Goal(context: managedContext);
            goal.goalDescription = goalDescription;
            goal.goalType = goalType.rawValue;
            goal.goalCompletionValue = Int32(pointsTextField.text!)!;
            goal.goalProgress = Int32(0);
            do {
                try managedContext.save();
                print("Successfully saved data.");
                completion(true);
            } catch {
                debugPrint("Could not save: \(error.localizedDescription)");
                completion(false);
            }
        } else {
        guard let managedContext = appDelegate?.managedObjectContext else {return;}
            let entityDescription = NSEntityDescription.entity(forEntityName: "Goal",
                                                               in: managedContext);
            let goal = Goal(entity: entityDescription!, insertInto: managedContext);
            goal.goalDescription = goalDescription;
            goal.goalType = goalType.rawValue;
            goal.goalCompletionValue = Int32(pointsTextField.text!)!;
            goal.goalProgress = Int32(0);
            do {
                try managedContext.save();
                print("Successfully saved data.");
                completion(true);
            } catch {
                debugPrint("Could not save: \(error.localizedDescription)");
                completion(false);
            }
    }
    }
}
