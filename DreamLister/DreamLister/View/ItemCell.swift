//
//  ItemCell.swift
//  DreamLister
//
//  Created by robot on 3/14/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!;
    
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    func configureCell(item: Item) {
        
        title.text = item.title;
        price.text = "$\(item.price)";
        details.text = item.details;
    }
    
}
