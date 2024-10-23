//
//  Planet.swift
//  assignment_17
//
//  Created by Cotne Chubinidze on 21.10.24.
//

import Foundation
import UIKit

class Planet {
    let name: String
    let area: String
    let mass: String
    let temperature: String
    let image: UIImage
    var isFavourite: Bool
    
    init(name: String, area: String, mass: String, temperature: String, image: UIImage) {
        self.name = name
        self.area = area
        self.mass = mass
        self.temperature = temperature
        self.image = image
        self.isFavourite = false
    }
}
