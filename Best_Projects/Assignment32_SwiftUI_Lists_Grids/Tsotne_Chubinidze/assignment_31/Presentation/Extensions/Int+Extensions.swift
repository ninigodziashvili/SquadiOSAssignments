//
//  Int+Extensions.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 14.12.24.
//
import Foundation

extension Int {
    var asTimes: String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60

        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}


