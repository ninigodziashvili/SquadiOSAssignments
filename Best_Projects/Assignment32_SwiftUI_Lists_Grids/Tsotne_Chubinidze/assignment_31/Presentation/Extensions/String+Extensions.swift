//
//  String+Extensions.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 15.12.24.
//
import Foundation

extension String {
    var toInt: Int {
        return Int(self)!
    }
}

extension String {
    func toTimeFormat() -> String {
        let components = self.split(separator: ":")
        
        guard components.count == 3 else { return "Invalid Time Format" }
        
        let hours = components[0] == "00" ? nil : "\(Int(components[0])!) სთ"
        let minutes = components[1] == "00" ? nil : "\(Int(components[1])!) წთ"
        let seconds = components[2] == "00" ? nil : "\(Int(components[2])!) წმ"
        
        let formattedComponents = [hours, minutes, seconds].compactMap { $0 }
        
        return formattedComponents.isEmpty ? "0 წმ" : formattedComponents.joined(separator: " ")
    }
}

extension String {
    func asShortTime() -> String {
        let components = self.split(separator: ":")
        guard components.count == 3 else { return "Invalid Time Format" }
        
        let hoursInMinutes = (Int(components[0]) ?? 0) * 60
        let minutes = Int(components[1]) ?? 0
        let totalMinutes = hoursInMinutes + minutes
        let seconds = Int(components[2]) ?? 0
        
        return String(format: "%02d:%02d", totalMinutes, seconds)
    }
}
