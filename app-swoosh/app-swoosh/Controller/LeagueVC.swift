//
//  LeagueVC.swift
//  app-swoosh
//
//  Created by robot on 4/26/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {

    var player: Player!;
    
    @IBOutlet weak var nextBtn: BorderButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = Player();
    }
    
    @IBAction func onNextTapped(_ sender: Any) {
        //Programmatic segue on button tap.
        performSegue(withIdentifier: "skillVCSegue", sender: self);
    }
    
    @IBAction func onMensTapped(_ sender: Any) {
        selectLeague(leagueType: "mens");
    }
    
    @IBAction func onWomensTapped(_ sender: Any) {
        selectLeague(leagueType: "womens");
    }
    
    @IBAction func onCoedTapped(_ sender: Any) {
        selectLeague(leagueType: "coed");
    }
    
    func selectLeague(leagueType: String) {
        player.desiredLeague = leagueType;
        nextBtn.isEnabled = true;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
