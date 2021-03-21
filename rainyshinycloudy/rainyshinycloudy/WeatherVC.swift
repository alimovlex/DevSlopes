//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by robot on 3/15/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!;
    
    @IBOutlet weak var currentTempLabel: UILabel!;
    
    @IBOutlet weak var locationLabel: UILabel!;
    
    @IBOutlet weak var currentWeatherImage: UIImageView!;
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!;
    
    @IBOutlet weak var tableView: UITableView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }


}

