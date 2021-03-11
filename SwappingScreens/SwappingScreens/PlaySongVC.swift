//
//  PlaySongVC.swift
//  SwappingScreens
//
//  Created by robot on 3/11/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class PlaySongVC: UIViewController {

    @IBOutlet weak var songTitleLbl: UILabel!;
    
    private var _selectedSong:String!;
    
    var selectedSong: String {
        get {
            return _selectedSong;
        } set {
            _selectedSong = newValue;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        songTitleLbl.text = _selectedSong;
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
