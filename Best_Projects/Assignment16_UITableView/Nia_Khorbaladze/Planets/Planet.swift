//
//  Planet.swift
//  Planets
//
//  Created by Nkhorbaladze on 18.10.24.
//

import UIKit

class Planet {
    enum planetName: String {
        case Mars
        case Jupiter
        case Earth
        case Saturn
        case Neptune
        case Uranus
        case Venus
        case Mercury
    }
    
    var name: planetName
    
    init(name: planetName) {
        self.name = name
    }
    
    func getTemperature() -> String {
        switch name {
        case .Mars:
            return "-63°C"
        case .Jupiter:
            return "-108°C"
        case .Earth:
            return "15°C"
        case .Saturn:
            return "-139°C"
        case .Neptune:
            return "-214°C"
        case .Uranus:
            return "-197°C"
        case .Venus:
            return "462°C"
        case .Mercury:
            return "167°C"
        }
    }
    
    func getMass() -> String {
        switch name {
        case .Mars:
            return "6.39×10^23 kg"
        case .Jupiter:
            return "1.90×10^27 kg"
        case .Earth:
            return "5.97×10^24 kg"
        case .Saturn:
            return "5.68×10^26 kg"
        case .Neptune:
            return "1.02×10^26 kg"
        case .Uranus:
            return "8.68×10^25 kg"
        case .Venus:
            return "4.87×10^24 kg"
        case .Mercury:
            return "3.30×10^23 kg"
        }
    }
}
