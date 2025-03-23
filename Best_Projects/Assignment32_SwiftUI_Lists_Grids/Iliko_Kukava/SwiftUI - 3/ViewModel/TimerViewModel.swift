//
//  TimerViewModel.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/11/24.
//

import Foundation
import Combine
import AVFoundation
import UIKit
import AudioToolbox
import SwiftUI

func playSystemSound() {
    AudioServicesPlaySystemSound(1330)
}

class TimerViewModel: ObservableObject {
    @AppStorage("timers") private var savedTimersData: Data = Data()
    
    @Published var timerName = ""
    @Published var hours = ""
    @Published var minutes = ""
    @Published var seconds = ""
    @Published var timers: [TimerModel] = [] {
        didSet {
            saveTimers()
        }
    }
    
    private var timerCancellables: [UUID: AnyCancellable] = [:]
    private var cancellables: Set<AnyCancellable> = []
    var audioPlayer: AVAudioPlayer?
    
    init() {
        timerCancellables.removeAll()
        loadTimers()
    }
    
    func loadTimers() {
        if let decodedTimers = try? JSONDecoder().decode([TimerModel].self, from: savedTimersData) {
            self.timers = decodedTimers.map { timer in
                var newTimer = timer
                newTimer.isRunning = false
                newTimer.remainingTime = timer.originalHours * 3600 + timer.originalMinutes * 60 + timer.originalSeconds
                return newTimer
            }
        }
    }

    
    func saveTimers() {
        if let encodedTimers = try? JSONEncoder().encode(timers) {
            savedTimersData = encodedTimers
        }
    }

    func playSound() {
        if let url = Bundle.main.url(forResource: "notification_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing custom sound: \(error)")
                playSystemSound()
            }
        } else {
            playSystemSound()
        }
    }

    func addTimer() {
        let newTimer = TimerModel(
            name: timerName.isEmpty ? "Unnamed Timer" : timerName,
            hours: Int(hours) ?? 0,
            minutes: Int(minutes) ?? 0,
            seconds: Int(seconds) ?? 0,
            dateCreated: Date()
        )
        timers.append(newTimer)
        
        timerName = ""
        hours = ""
        minutes = ""
        seconds = ""
    }
    
    func sumTimersByDate() -> [Date: (totalHours: Int, totalMinutes: Int, totalSeconds: Int)] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let groupedTimers = Dictionary(grouping: timers) { timer in
            formatter.string(from: timer.dateCreated)
        }
        
        var summedTimers = [Date: (totalHours: Int, totalMinutes: Int, totalSeconds: Int)]()
        
        for (dateString, timerGroup) in groupedTimers {
            var totalHours = 0
            var totalMinutes = 0
            var totalSeconds = 0
            
            for timer in timerGroup {
                totalHours += timer.hours
                totalMinutes += timer.minutes
                totalSeconds += timer.seconds
            }
            
            totalMinutes += totalSeconds / 60
            totalSeconds %= 60
            totalHours += totalMinutes / 60
            totalMinutes %= 60
            
            if let date = formatter.date(from: dateString) {
                summedTimers[date] = (totalHours, totalMinutes, totalSeconds)
            }
        }
        
        return summedTimers
    }


    
    func startTimer(for timerId: UUID) {
        if let index = timers.firstIndex(where: { $0.id == timerId }), timers[index].remainingTime > 0 {
            timers[index].isRunning = true
            
            let timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    if self.timers[index].remainingTime > 0 {
                        self.timers[index].remainingTime -= 1
                    } else {
                        self.timers[index].isRunning = false
                        self.timerCancellables.removeValue(forKey: timerId)
                        self.cancellables.removeAll()
                        self.playSound()
                        self.triggerHapticFeedback()
                    }
                }
            cancellables.insert(timer)
            timerCancellables[timerId] = timer
        }
    }
    
    func pauseTimer(for timerId: UUID) {
        if let _ = timerCancellables[timerId] {
            timerCancellables[timerId]?.cancel()
            timerCancellables.removeValue(forKey: timerId)
        }
        
        if let index = timers.firstIndex(where: { $0.id == timerId }) {
            timers[index].isRunning = false
        }
    }
    
    func resetTimer(for timerId: UUID) {
        if let index = timers.firstIndex(where: { $0.id == timerId }) {
            timers[index].remainingTime = timers[index].originalHours * 3600 + timers[index].originalMinutes * 60 + timers[index].originalSeconds
            
            if timers[index].isRunning {
                timers[index].isRunning = true
            } else {
                timers[index].isRunning = false
            }
        }
    }
    
    func formattedTime(for timerId: UUID) -> String {
        if let timer = timers.first(where: { $0.id == timerId }) {
            let hours = timer.remainingTime / 3600
            let minutes = (timer.remainingTime % 3600) / 60
            let seconds = timer.remainingTime % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return "00:00:00"
    }
    
    func triggerHapticFeedback() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.warning)
    }
}

extension TimerViewModel {
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    func timersForDay(of timer: TimerModel) -> [TimerModel] {
        let calendar = Calendar.current
        return timers.filter { calendar.isDate($0.dateCreated, inSameDayAs: timer.dateCreated) }
    }

    func daySessionsCount(for timer: TimerModel) -> Int {
        timersForDay(of: timer).count
    }

    func dayTotalTime(for timer: TimerModel) -> String {
        let timersForDay = timersForDay(of: timer)
        let totalSeconds = timersForDay.reduce(0) { $0 + $1.hours * 3600 + $1.minutes * 60 + $1.seconds }
        return formatTime(totalSeconds)
    }

    func dayAverageTime(for timer: TimerModel) -> String {
        let timersForDay = timersForDay(of: timer)
        guard !timersForDay.isEmpty else { return "0 min" }
        let totalSeconds = timersForDay.reduce(0) { $0 + $1.hours * 3600 + $1.minutes * 60 + $1.seconds }
        let averageSeconds = totalSeconds / timersForDay.count
        return formatTime(averageSeconds)
    }

    private func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return hours > 0 ? "\(hours) სთ \(minutes) წთ" : "\(minutes) წთ"
    }
}
