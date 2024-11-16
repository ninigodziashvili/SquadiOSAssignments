//
//  Animations.swift
//  Assignment 25
//
//  Created by Giorgi Gakhokidze on 15.11.24.
//

import UIKit
import Foundation

final class Animations {
    var animator = UIViewPropertyAnimator()
    
     func animateMVPlabel(_ label: UILabel) {
        UIView.animate(withDuration: 2, delay: 2,options: [.repeat, .autoreverse], animations: {
            label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
    
     func loadBall(_ myView: UIView) {
        animator = UIViewPropertyAnimator(duration: 3, dampingRatio: 0.4) {
            myView.frame = CGRect(x: myView.frame.midX, y: 100, width: 50, height: 150)
        }
        animator.startAnimation()
    }
    
     func loadCharacter(_ myView: UIImageView) {
        animator = UIViewPropertyAnimator(duration: 3, dampingRatio: 1) { 
            myView.frame = CGRect(x: 0, y: 100, width: 150, height: 100)
        }
        animator.startAnimation()
    }
}
