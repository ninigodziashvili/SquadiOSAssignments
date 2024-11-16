//
//  Banana.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class Banana {
    var position: CGPoint
    let image: UIImage

    init(position: CGPoint, image: UIImage) {
        self.position = position
        self.image = image
    }

    func fall() {
        position.y += 2.0
    }
}
