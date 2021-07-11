//
//  AddChannelVC.swift
//  Smack
//
//  Created by robot on 7/11/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var nameTxt: UITextField!;
    @IBOutlet weak var chanDesc: UITextField!;
    @IBOutlet weak var bgView: UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView();
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    func setUpView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)));
        bgView.addGestureRecognizer(tap);
        nameTxt.delegate = self;
        chanDesc.delegate = self;
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
        
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder]);
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil);
    }
    
    //hiding the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTxt:
            textField.resignFirstResponder();
            chanDesc.becomeFirstResponder();
        case chanDesc:
            textField.resignFirstResponder();
            createChannelPressed(self);
        default:
            break;
        }
     return true
    }
    
}
