//
//  TimerViewModel.swift
//  Assignment30
//
//  Created by Giorgi on 11.12.24.
//
import SwiftUI

final class TimersViewModelREAL: ObservableObject {
    @Published var timers: [TimerModel] = []
    
    private let userDefaultsKey = "savedTimers"

    init() {
        loadTimers()
    }
    
    func addTimer(timerName: String, hours: Int, minutes: Int, seconds: Int) {
        let newTimer = TimerModel(timerName: timerName, hours: hours, minutes: minutes, seconds: seconds)
        timers.append(newTimer)
        saveTimers()
    }

    func deleteTimer(id: UUID) {
        timers.removeAll { $0.id == id }
        saveTimers()
    }

    func toggleTimerRunning(timer: TimerModel) {
        if timer.isRunning {
            timer.timer?.invalidate()
        } else {
            timer.startTime = Date()
            timer.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.updateCountdown(for: timer)
            }
        }
        timer.isRunning.toggle()
        saveTimers()
    }

    func resetTimer(timer: TimerModel) {
        if timer.duration == 0 { return }
        timer.timeDict[timer.startTime] = timer.duration
        timer.duration = 0
        timer.timer?.invalidate()
        timer.isRunning = false
        timer.seconds = timer.initialTime[2]
        timer.minutes = timer.initialTime[1]
        timer.hours = timer.initialTime[0]
        saveTimers()
    }

    private func updateCountdown(for timer: TimerModel) {
        timer.duration += 1
        if timer.seconds > 0 {
            timer.seconds -= 1
        } else if timer.minutes > 0 {
            timer.minutes -= 1
            timer.seconds = 59
        } else if timer.hours > 0 {
            timer.hours -= 1
            timer.minutes = 59
            timer.seconds = 59
        } else {
            timer.timeDict[timer.startTime] = timer.duration
            saveTimers()
            AudioManager.shared.playSound(named: "pong")
            timer.timer?.invalidate()
            timer.isRunning = false
        }
    }

    func saveTimers() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(timers) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }

   func loadTimers() {
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedTimers = try? decoder.decode([TimerModel].self, from: savedData) {
            timers = savedTimers
        }
    }
}
