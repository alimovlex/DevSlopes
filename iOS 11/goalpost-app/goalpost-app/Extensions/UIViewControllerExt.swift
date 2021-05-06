//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

//Custom UINavigationController
extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition();
        transition.duration = 0.3;
        transition.type = CATransitionType.push;
        transition.subtype = CATransitionSubtype.fromRight;
        self.view.window?.layer.add(transition, forKey: kCATransition);
        
        present(viewControllerToPresent, animated: false, completion: nil);
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition();
        transition.duration = 0.3;
        transition.type = CATransitionType.push;
        transition.subtype = CATransitionSubtype.fromRight;
        
        guard let presentedViewController = presentedViewController else {return;}
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition);
            self.present(viewControllerToPresent, animated: false, completion: nil);
        }
    }
    
    func dismissDetail() {
        let transition = CATransition();
        transition.duration = 0.3;
        transition.type = CATransitionType.push;
        transition.subtype = CATransitionSubtype.fromLeft;
        self.view.window?.layer.add(transition, forKey: kCATransition);
        
        dismiss(animated: false, completion: nil);
    }
}

