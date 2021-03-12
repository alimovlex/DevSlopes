//
//  PartyCell.swift
//  PartyRockApp
//
//  Created by robot on 3/12/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class PartyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var videoPreviewImage: UIImageView!;
    
    @IBOutlet weak var videoTitle: UILabel!;
    
    func updateUI(partyRock: PartyRock) {
        videoTitle.text = partyRock.videoTitle;
        
        let url = URL(string: partyRock.imageURL)!;
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url);
                DispatchQueue.global().sync {
                    self.videoPreviewImage.image = UIImage(data: data);
                }
            } catch {
                //handle the error
            }
        }
        //TODO: set image from url
    }

}
