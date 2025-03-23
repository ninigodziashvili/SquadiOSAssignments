//
//  TimerModel.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/11/24.
//
import Foundation

struct TimerModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    var originalHours: Int
    var originalMinutes: Int
    var originalSeconds: Int
    
    var isRunning: Bool = false
    var remainingTime: Int = 0
    
    var dateCreated: Date
    
    init(name: String, hours: Int, minutes: Int, seconds: Int, dateCreated: Date = Date()) {
        self.name = name.capitalized
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.originalHours = hours
        self.originalMinutes = minutes
        self.originalSeconds = seconds
        self.remainingTime = hours * 3600 + minutes * 60 + seconds
        self.dateCreated = dateCreated
    }
}
