//
//  ProfileVC.swift
//  Smack
//
//  Created by robot on 7/4/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var profileImg: UIImageView!;
    
    @IBOutlet weak var userName: UILabel!;
    
    @IBOutlet weak var userEmail: UILabel!;
    
    @IBOutlet weak var bgView: UIView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupView();
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser();
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil);
        dismiss(animated: true, completion: nil);
    }
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)));
        bgView.addGestureRecognizer(tap);
        
        userName.text = UserDataService.instance.name;
        userEmail.text = UserDataService.instance.email;
        profileImg.image = UIImage(named: UserDataService.instance.avatarName);
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components:
            UserDataService.instance.avatarColor);
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil);
    }
}
