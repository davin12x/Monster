//
//  ViewController.swift
//  Monster
//
//  Created by Lalit on 2016-01-12.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Monster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var imageArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imageArray.append(img!)
        }
        Monster.animationImages = imageArray
        Monster.animationDuration = 0.8
        Monster.animationRepeatCount = 0
        Monster.startAnimating()
        
    }
}

