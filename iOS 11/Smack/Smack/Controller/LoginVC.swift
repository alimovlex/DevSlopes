//
//  LoginVC.swift
//  Smack
//
//  Created by robot on 4/30/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    // Outlets
    
    @IBOutlet weak var emailTxt: UITextField!;
    @IBOutlet weak var passwordTxt: UITextField!;
    @IBOutlet weak var spinner: UIActivityIndicatorView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setUpView();
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false;
        spinner.startAnimating();
        
        guard let email = emailTxt.text, emailTxt.text != ""
            else {
                return;
        }
        
        guard let password = passwordTxt.text, passwordTxt.text != ""
            else {
                return;
        }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil);
                        self.spinner.isHidden = true;
                        self.spinner.stopAnimating();
                        self.dismiss(animated: true, completion: nil);
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil);
    }
    
    func setUpView() {
        spinner.isHidden = true;
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        emailTxt.delegate = self;
        passwordTxt.delegate = self;
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
    }
    
    //hiding the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTxt:
            textField.resignFirstResponder();
            passwordTxt.becomeFirstResponder();
        case passwordTxt:
            textField.resignFirstResponder();
            loginPressed(self);
        default:
            break;
        }
     return true
    }
    
}
