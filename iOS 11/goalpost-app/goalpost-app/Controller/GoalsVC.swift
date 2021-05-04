//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by robot on 5/4/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!;

    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("button was pressed");
    }

}

