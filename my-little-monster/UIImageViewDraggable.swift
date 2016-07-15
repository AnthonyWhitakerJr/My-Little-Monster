//
//  UIDraggableImageView.swift
//  my-little-monster
//
//  Created by Anthony Whitaker on 7/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

class UIImageViewDraggable : UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.center = touch.locationInView(self.superview)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)
            if CGRectContainsPoint(target.frame, position){
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
        }
        
        self.center = originalPosition
    }
}