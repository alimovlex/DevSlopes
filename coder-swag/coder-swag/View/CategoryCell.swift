//
//  CategoryCell.swift
//  coder-swag
//
//  Created by robot on 4/28/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!;
    @IBOutlet weak var categoryTitle: UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
