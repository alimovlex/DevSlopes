//
//  ViewController.swift
//  PageTheScroll
//
//  Created by robot on 3/9/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!;
    var images = [UIImageView]();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0;
        
        let scrollWidth = scrollView.frame.size.width;
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png");
            let imageView = UIImageView(image: image);
            images.append(imageView);
            
            var newX: CGFloat = 0.0;
            
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x);
            
            contentWidth += newX;
            
            scrollView.addSubview(imageView);
            //printing the image in the desired coordinates
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.width / 2) - 75, width: 150, height: 150);
        }
        
        scrollView.clipsToBounds = false;
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height);
    }
    
}

