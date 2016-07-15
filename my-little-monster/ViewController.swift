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
    @IBOutlet weak var heartImage: UIImageViewDraggable!
    @IBOutlet weak var foodImage: UIImageViewDraggable!
    @IBOutlet weak var monsterImage: UIImageViewMonster!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    
    var maxPenalties : Int {
        return skulls.count
    }
    
    var penalties = 0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartImage.dropTarget = monsterImage
        foodImage.dropTarget = monsterImage
        
        for skull in skulls {
            skull.alpha = DIM_ALPHA
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("ITEM DROPPED")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        for skull in skulls {
            skull.alpha = DIM_ALPHA
        }
        
        penalties += 1
        
        for i in 0...penalties - 1 {
            skulls[i].alpha = OPAQUE
        }
        
        if penalties >= maxPenalties {
            gameOver()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
    }

}

