//
//  DateExtensions.swift
//  Assignment 30
//
//  Created by Giorgi Gakhokidze on 13.12.24.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}

extension TimeInterval {
     func formatTimeInterval() -> String {
         let hours = Int(self) / 3600
         let minutes = (Int(self) % 3600) / 60
         let seconds = Int(self) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
