//
//  ViewController.swift
//  PartyRockApp
//
//  Created by robot on 3/12/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!;
    
    var partyRocks = [PartyRock]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let p1 = PartyRock(imageURL: "https://i.ytimg.com/vi/SjmTFIHX1yo/maxresdefault.jpg", videoURL: "<iframe width=\"320\" height=\"175\" src=\"https://www.youtube.com/embed/ev4bY1SkZLg\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Lights Out");
        
        let p2 = PartyRock(imageURL: "https://i.ytimg.com/vi/KvgpWoYgHH4/maxresdefault.jpg", videoURL: "<iframe width=\"320\" height=\"175\" src=\"https://www.youtube.com/embed/1w9DiGlZksU\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Let's Get Ridiculous");
        let p3 = PartyRock(imageURL: "https://i.ytimg.com/vi/2wUxw6GH3IM/hqdefault.jpg", videoURL: "<iframe width=\"320\" height=\"175\" src=\"https://www.youtube.com/embed/vg_nvEGryA4\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Juicy Wiggle Lesson");
        let p4 = PartyRock(imageURL: "https://i.ytimg.com/vi/5oi4RsL2kwk/maxresdefault.jpg", videoURL: "<iframe width=\"320\" height=\"175\" src=\"https://www.youtube.com/embed/gZIqW92GaTQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Party Rock Commercial");
        let p5 = PartyRock(imageURL: "https://i.ytimg.com/vi/k7OtcWVaT5s/maxresdefault.jpg", videoURL: "<iframe width=\"320\" height=\"175\" src=\"https://www.youtube.com/embed/tWyuglGCKgE\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Juicy Wiggle");
        
        partyRocks.append(p1)
        partyRocks.append(p2)
        partyRocks.append(p3)
        partyRocks.append(p4)
        partyRocks.append(p5)
        
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCell {
            
            let partyRock = partyRocks[indexPath.row];
            
            cell.updateUI(partyRock: partyRock);
            
            return cell;
            
        } else {
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRocks.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let partyRock = partyRocks[indexPath.row];
        
        performSegue(withIdentifier: "VideoVC", sender: partyRock);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoVC {
            
            if let party = sender as? PartyRock {
                destination.partyRock = party;
            }
        }
    }

}

