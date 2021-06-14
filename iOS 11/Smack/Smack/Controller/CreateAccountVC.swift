//
//  CreateAccountVC.swift
//  Smack
//
//  Created by robot on 4/30/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    var avatarName = "profileDefault";
    var avatarColor = "[0.5, 0.5, 1]";
    var bgColor: UIColor?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupView();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName;
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1);
            }
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        
        spinner.isHidden = false;
        spinner.startAnimating();
        
        guard let name = usernameTxt.text , usernameTxt.text != ""
            else
        {
            return;
        }
        
        
        guard let email = emailTxt.text , emailTxt.text != ""
            else
        {
            return;
        }
        
        guard let pass = passTxt.text , passTxt.text != ""
            else
        {
            return;
        }
        //registering user
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            if success {
                                self.spinner.isHidden = true;
                                self.spinner.stopAnimating();
                                self.performSegue(withIdentifier: UNWIND, sender: nil);
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil);
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil);
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
        let r = CGFloat(arc4random_uniform(255)) / 255;
        let g = CGFloat(arc4random_uniform(255)) / 255;
        let b = CGFloat(arc4random_uniform(255)) / 255;
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1);
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor;
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil);
    }
    
    func setupView() {
        spinner.isHidden = true;
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
               view.addGestureRecognizer(tap);
        usernameTxt.delegate = self;
        emailTxt.delegate = self;
        passTxt.delegate = self;
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
        
    }
    
    
    //hiding the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTxt:
            textField.resignFirstResponder();
            emailTxt.becomeFirstResponder();
        case emailTxt:
            textField.resignFirstResponder();
            passTxt.becomeFirstResponder();
        case passTxt:
            textField.resignFirstResponder();
        default:
            break;
        }
     return true
    }
    
}
