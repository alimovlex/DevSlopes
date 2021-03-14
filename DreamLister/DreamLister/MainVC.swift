//
//  MainVC.swift
//  DreamLister
//
//  Created by robot on 3/13/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!;
    @IBOutlet weak var segment: UISegmentedControl!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0;
    }


}

