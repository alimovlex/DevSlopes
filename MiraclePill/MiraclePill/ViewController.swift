//
//  ViewController.swift
//  MiraclePill
//
//  Created by robot on 3/9/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
//declaring the class with protocols
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad();
        statePicker.dataSource = self;
        statePicker.delegate = self;
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        nameField.delegate = self; //delegating the keyboard dismissal on return
        addressField.delegate = self; //delegating the keyboard dismissal on return
        cityField.delegate = self;
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var statePicker: UIPickerView!; //a reference variable to the UIPicker
    @IBOutlet weak var statePickerBtn: UIButton!;
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    //an array of states in UIPickerView
    let states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California",
                  "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
                  "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
                  "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
                  "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
                  "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                  "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
                  "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
                  "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
                  "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"];
    //a reference to the UIButton variable from the view
    @IBAction func stateBtnPressed(_ sender: Any) {
        statePicker.isHidden = false;
    }
    //number of picked value in UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    //The number of rows in UIPickerView which is equal to the amount of states in array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count;
    }
    //the title in rows for the UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row];
    }
    //The actions for the selected state in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statePickerBtn.setTitle(states[row], for: UIControl.State.normal);
        statePicker.isHidden = true;
    }
    
    //hiding the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            textField.resignFirstResponder();
        case addressField:
            textField.resignFirstResponder();
        case cityField:
            textField.resignFirstResponder();
        default:
            break;
        }
     return true
    }
    
}

