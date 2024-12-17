//
//  TimerModel.swift
//  Assignment30
//
//  Created by Giorgi on 11.12.24.
//

import SwiftUI

final class TimerModel: Identifiable, ObservableObject, Codable {
    var id: UUID
    @Published var timerName: String
    @Published var hours: Int
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var isRunning: Bool = false
    @Published var timer: Timer? = nil
    @Published var duration: Int = 0
    @Published var startTime: Date = Date()
    @Published var timeDict: [Date: Int] = [:]
    let initialTime: [Int]

    enum CodingKeys: String, CodingKey {
        case id, timerName, hours, minutes, seconds, isRunning, duration, startTime, timeDict, initialTime
    }

    init(id: UUID = UUID(), timerName: String, hours: Int, minutes: Int, seconds: Int) {
        self.id = id
        self.timerName = timerName
        self.hours = max(0, hours)
        self.minutes = min(59, max(0, minutes))
        self.seconds = min(59, max(0, seconds))
        self.initialTime = [hours, minutes, seconds] 
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        timerName = try container.decode(String.self, forKey: .timerName)
        hours = try container.decode(Int.self, forKey: .hours)
        minutes = try container.decode(Int.self, forKey: .minutes)
        seconds = try container.decode(Int.self, forKey: .seconds)
        isRunning = try container.decode(Bool.self, forKey: .isRunning)
        duration = try container.decode(Int.self, forKey: .duration)
        startTime = try container.decode(Date.self, forKey: .startTime)
        timeDict = try container.decode([Date: Int].self, forKey: .timeDict)
        initialTime = try container.decode([Int].self, forKey: .initialTime)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(timerName, forKey: .timerName)
        try container.encode(hours, forKey: .hours)
        try container.encode(minutes, forKey: .minutes)
        try container.encode(seconds, forKey: .seconds)
        try container.encode(isRunning, forKey: .isRunning)
        try container.encode(duration, forKey: .duration)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(timeDict, forKey: .timeDict)
        try container.encode(initialTime, forKey: .initialTime)
    }
}

