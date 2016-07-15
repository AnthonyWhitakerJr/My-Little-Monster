//
//  UIMonsterImageView.swift
//  my-little-monster
//
//  Created by Anthony Whitaker on 7/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

class UIImageViewMonster: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        self.image = UIImage(named: "idle1")
        
        playAnimation(4, baseFileName: "idle", repetition: true)
    }
    
    func playDeathAnimation() {
        self.image = UIImage(named: "dead5")
        
        playAnimation(5, baseFileName: "dead", repetition: false)
    }
    
    private func playAnimation(frameCount: Int, baseFileName: String, repetition: Bool) {
        var images = [UIImage]()
        for i in 1...frameCount {
            images.append(UIImage(named: "\(baseFileName)\(i)")!)
        }
        self.animationImages = images
        self.animationDuration = 0.8
        self.animationRepeatCount = repetition ? 0 : 1
        self.startAnimating()
    }
}