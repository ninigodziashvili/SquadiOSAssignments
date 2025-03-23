//
//  Timer.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//
import SwiftUI

struct TimerModel: Codable {
    var id = UUID()
    var name: String
    var duration: TimeInterval
    var defaultDuration: TimeInterval
    var isRunning: Bool = false
    var startDate: Date?
    var history: [HistoryEntry] = []
    
    func formatedTime(from seconds: TimeInterval, isQuickTimer: Bool = false) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        var formattedTime: String = ""
        
        if hours > 0 || !isQuickTimer {
            formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            formattedTime = String(format: "%02d:%02d", minutes, seconds)
        }
        
        return formattedTime
    }
}

struct HistoryEntry: Codable {
    var id = UUID()
    var date: String
    var sessions: [Session]
    
    struct Session: Codable {
        var id = UUID()
        var startTime: String
        var endTime: String
        var duration: TimeInterval
    }
}

struct SessionStatistics {
    let sessionCount: Int
    let totalLength: TimeInterval
    let averageLength: TimeInterval
}
