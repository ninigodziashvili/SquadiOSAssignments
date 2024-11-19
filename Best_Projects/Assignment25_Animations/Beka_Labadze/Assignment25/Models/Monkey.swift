//
//  Monkey.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class Monkey {
    var position: CGPoint
    let image: UIImage

    init(position: CGPoint, image: UIImage) {
        self.position = position
        self.image = image
    }

    func move(to position: CGPoint) {
        self.position = position
    }
}
