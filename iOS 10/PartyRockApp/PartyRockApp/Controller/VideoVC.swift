//
//  VideoVC.swift
//  PartyRockApp
//
//  Created by robot on 3/12/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!;
    
    @IBOutlet weak var titleLbl: UILabel!;
    private var _partyRock: PartyRock!;
    
    var partyRock: PartyRock {
        get {
            return _partyRock;
        } set {
            _partyRock = newValue;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLbl.text = partyRock.videoTitle;
        webView.loadHTMLString(partyRock.videoURL, baseURL: nil);
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil);
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
