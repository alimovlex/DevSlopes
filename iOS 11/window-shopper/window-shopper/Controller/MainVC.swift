//
//  ViewController.swift
//  window-shopper
//
//  Created by robot on 4/27/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    
    @IBOutlet weak var wageTxt: CurrencyTxtField!;
    @IBOutlet weak var priceTxt: CurrencyTxtField!;
    @IBOutlet weak var resultLbl: UILabel!;
    @IBOutlet weak var hoursLbl: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap);
        let calcBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60));
        calcBtn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1);
        calcBtn.setTitle("Calculate", for: .normal);
        calcBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal);
        calcBtn.addTarget(self, action: #selector(MainVC.calculate), for: .touchUpInside);
        
        wageTxt.inputAccessoryView = calcBtn;
        priceTxt.inputAccessoryView = calcBtn;
        
        resultLbl.isHidden = true;
        hoursLbl.isHidden = true;
    }
    
    @objc func calculate() {
        if let wageTxt = wageTxt.text, let priceTxt = priceTxt.text {
            if let wage = Double(wageTxt), let price = Double(priceTxt) {
                view.endEditing(true);
                resultLbl.isHidden = false;
                hoursLbl.isHidden = false;
                resultLbl.text = "\(Wage.getHours(forWage: wage, andPrice: price))";
            }
        }
    }
    
    @IBAction func clearCalculatorPressed(_ sender: Any) {
        resultLbl.isHidden = true;
        hoursLbl.isHidden = true;
        wageTxt.text = "";
        priceTxt.text = "";
    }
    

}

