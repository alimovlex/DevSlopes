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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
               view.addGestureRecognizer(tap);
        usernameTxt.delegate = self;
        emailTxt.delegate = self;
        passTxt.delegate = self;
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
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
                print("registered user!");
            }
        }
        
    }
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil);
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
