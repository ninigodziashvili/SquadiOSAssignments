//
//  PlanetModel.swift
//  TBC_Task_17
//
//  Created by iliko on 10/20/24.
//

import UIKit

class Planet {
    
    let name: String
    let area: Double
    let temperature: Int
    let mass: Double
    let imageName: String
    
    init(name: String, area: Double, temperature: Int, mass: Double, imageName: String) {
        self.name = name
        self.area = area
        self.temperature = temperature
        self.mass = mass
        self.imageName = imageName
    }
    
    static func == (lhs: Planet, rhs: Planet) -> Bool {
        return lhs.name == rhs.name
    }
}
