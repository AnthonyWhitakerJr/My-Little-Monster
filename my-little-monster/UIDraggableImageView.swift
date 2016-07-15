//
//  UIDraggableImageView.swift
//  my-little-monster
//
//  Created by Anthony Whitaker on 7/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

class UIDraggableImageView : UIImageView {
    
    var originalPosition: CGPoint!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.center = touch.locationInView(self.superview)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.center = originalPosition
    }
}