//
//  ViewController.swift
//  my-little-monster
//
//  Created by Anthony Whitaker on 7/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import AVFoundation

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
    var monsterHappy = true
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartImage.dropTarget = monsterImage
        foodImage.dropTarget = monsterImage
        
        toggleCareItemAvailability(foodImage, availble: false)
        toggleCareItemAvailability(heartImage, availble: false)
        
        for skull in skulls {
            skull.alpha = DIM_ALPHA
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        musicPlayer.prepareToPlay()
        musicPlayer.play()
        sfxBite.prepareToPlay()
        sfxHeart.prepareToPlay()
        sfxDeath.prepareToPlay()
        sfxSkull.prepareToPlay()
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: NSNotification) {
        monsterHappy = true
        startTimer()
        
        if let image = notif.object as? UIImageViewDraggable {
            switch image.tag {
            case 0:
                sfxHeart.play()
            case 1:
                sfxBite.play()
            default:
                break
            }
        }
        
        toggleCareItemAvailability(foodImage, availble: false)
        toggleCareItemAvailability(heartImage, availble: false)
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        if !monsterHappy {
            for skull in skulls {
                skull.alpha = DIM_ALPHA
            }
            
            penalties += 1
            
            for i in 0...penalties - 1 {
                skulls[i].alpha = OPAQUE
            }
            
            sfxSkull.play()
            
            if penalties >= maxPenalties {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)
        
        switch rand {
        case 0:
            toggleCareItemAvailability(foodImage, availble: false)
            toggleCareItemAvailability(heartImage, availble: true)
        case 1:
            toggleCareItemAvailability(foodImage, availble: true)
            toggleCareItemAvailability(heartImage, availble: false)
        default:
            break
        }
        
        //TODO: Current item code?
        monsterHappy = false
    }
    
    func toggleCareItemAvailability(careItem: UIImageViewDraggable, availble: Bool) {
        if availble {
            careItem.alpha = OPAQUE
            careItem.userInteractionEnabled = true
        } else {
            careItem.alpha = DIM_ALPHA
            careItem.userInteractionEnabled = false
        }
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
        sfxDeath.play()
    }
    
}

