//
//  ViewController - touches.swift
//  Assignment 25
//
//  Created by Giorgi Gakhokidze on 15.11.24.
//

import Foundation
import UIKit

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: curryImageView)
        
        if curryImageView.bounds.contains(location) {
            isDragging = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else { return }
        
        curryImageView.translatesAutoresizingMaskIntoConstraints = true

        
        let location = touch.location(in: view)
        curryImageView.frame.origin.x = location.x - (curryImageView.frame.width/2)
        curryImageView.frame.origin.y = location.y - (curryImageView.frame.height/2)

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
    }
}

