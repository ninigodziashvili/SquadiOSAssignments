//
//  Timer+Logs.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 16.12.24.
//
import Foundation
import MyDateFormatter

extension TimerModel {
    mutating func logUseHistory(useTimeInSeconds: Int) {
        let dateFormatter = MyDateFormatter()
        let currentDate = Date()
        
        let startDate = currentDate.addingTimeInterval(-Double(useTimeInSeconds))
        
        let currentDay = dateFormatter.formatDateOnly(startDate)
        let startTime = dateFormatter.formatTimeOnly(startDate)
        
        let entry = HistoryEntry(startTime: startTime, useTimeInSeconds: useTimeInSeconds)
        
        history[currentDay, default: []].append(entry)
    }
}
