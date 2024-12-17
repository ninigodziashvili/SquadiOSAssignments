//
//  TimerModel.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 11.12.24.
//

import SwiftUI
import AVFoundation
import AudioToolbox

final class TimerModel: Identifiable, ObservableObject, Codable {
    
    var id = UUID()
    @Published var name: String
    @Published var hours: Int
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var isRunning: Bool
    var timer: Timer?
    
    var originalHours: Int
    var originalMinutes: Int
    var originalSeconds: Int
    var audioPlayer: AVAudioPlayer?
    
    @Published var usageHistory: [TimerUsage] = []
    
    var totalElapsedSeconds: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, hours, minutes, seconds, isRunning, originalHours, originalMinutes, originalSeconds, usageHistory, totalElapsedSeconds
    }
    
    struct TimerUsage: Codable {
        let duration: String
        let timestamp: Date
    }
    
    init(name: String = "Timer", hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.name = name
        self.originalHours = hours
        self.originalMinutes = minutes
        self.originalSeconds = seconds
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.isRunning = false
        
        loadUsageHistory()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(hours, forKey: .hours)
        try container.encode(minutes, forKey: .minutes)
        try container.encode(seconds, forKey: .seconds)
        try container.encode(isRunning, forKey: .isRunning)
        try container.encode(originalHours, forKey: .originalHours)
        try container.encode(originalMinutes, forKey: .originalMinutes)
        try container.encode(originalSeconds, forKey: .originalSeconds)
        try container.encode(usageHistory, forKey: .usageHistory)
        try container.encode(totalElapsedSeconds, forKey: .totalElapsedSeconds)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.hours = try container.decode(Int.self, forKey: .hours)
        self.minutes = try container.decode(Int.self, forKey: .minutes)
        self.seconds = try container.decode(Int.self, forKey: .seconds)
        self.isRunning = try container.decode(Bool.self, forKey: .isRunning)
        self.originalHours = try container.decode(Int.self, forKey: .originalHours)
        self.originalMinutes = try container.decode(Int.self, forKey: .originalMinutes)
        self.originalSeconds = try container.decode(Int.self, forKey: .originalSeconds)
        self.usageHistory = try container.decode([TimerUsage].self, forKey: .usageHistory)
        self.totalElapsedSeconds = try container.decode(Int.self, forKey: .totalElapsedSeconds)
    }
    
    func start() {
        if !isRunning {
            isRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        
        let elapsedHours = totalElapsedSeconds / 3600
        let elapsedMinutes = (totalElapsedSeconds % 3600) / 60
        let elapsedSeconds = totalElapsedSeconds % 60
        
        let duration = String(format: "%02d:%02d:%02d", elapsedHours, elapsedMinutes, elapsedSeconds)
        
        let usage = TimerUsage(duration: duration, timestamp: Date())
        usageHistory.append(usage)
        
        totalElapsedSeconds = 0
        
        saveUsageHistory()
    }
    
    func reload() {
        self.hours = originalHours
        self.minutes = originalMinutes
        self.seconds = originalSeconds
        stop()
        totalElapsedSeconds = 0
    }
    
    @objc private func updateTime() {
        if seconds > 0 {
            seconds -= 1
        } else if minutes > 0 {
            minutes -= 1
            seconds = 59
        } else if hours > 0 {
            hours -= 1
            minutes = 59
            seconds = 59
        } else {
            stop()
            if let soundAsset = NSDataAsset(name: "alarm") {
                do {
                    audioPlayer = try AVAudioPlayer(data: soundAsset.data)
                    audioPlayer?.play()
                } catch {
                    print("Error playing alarm sound: \(error.localizedDescription)")
                }
            } else {
                print("Sound asset not found!")
            }
        }
        
        if isRunning {
            totalElapsedSeconds += 1
        }
    }
    
    private func saveUsageHistory() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(usageHistory)
            UserDefaults.standard.set(data, forKey: "usageHistoryKey-\(id.uuidString)")
            print("Usage history saved: \(usageHistory)")
        } catch {
            print("Failed to save usage history: \(error)")
        }
    }

    func loadUsageHistory() {
        if let data = UserDefaults.standard.data(forKey: "usageHistoryKey-\(id.uuidString)") {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let history = try decoder.decode([TimerUsage].self, from: data)
                usageHistory = history
                print(usageHistory)
            } catch {
                print(error)
            }
        } else {
            print("Not found")
        }
    }

}
