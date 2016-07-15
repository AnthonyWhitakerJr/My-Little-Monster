//
//  ViewController.swift
//  my-little-monster
//
//  Created by Anthony Whitaker on 7/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var skulls: [UIImageView]!
    @IBOutlet weak var heartImage: UIDraggableImageView!
    @IBOutlet weak var foodImage: UIDraggableImageView!
    @IBOutlet weak var monsterImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var images = [UIImage]()
        for i in 1...4 {
            images.append(UIImage(named: "idle\(i)")!)
        }
        monsterImage.animationImages = images
        monsterImage.animationDuration = 0.8
        monsterImage.animationRepeatCount = 0
        monsterImage.startAnimating()
    }

}

