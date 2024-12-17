//
//  TimerEntitiy.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation
import MyDateFormatter

struct HistoryEntry: Codable, Equatable {
    let startTime: String
    let useTimeInSeconds: Int
}

struct TimerModel: Codable, Equatable, Identifiable {
    let id: String
    var name: String
    var timeAmount: Int
    var timePassed: Int
    var history: [String: [HistoryEntry]] = [:]
    var creationDate: Date
    
    init(id: String = UUID().uuidString, name: String, timeAmount: Int, timePassed: Int = 0, creation: Date = Date()) {
        self.id = id
        self.name = name
        self.timeAmount = timeAmount
        self.timePassed = timePassed
        self.creationDate = creation
    }
}
