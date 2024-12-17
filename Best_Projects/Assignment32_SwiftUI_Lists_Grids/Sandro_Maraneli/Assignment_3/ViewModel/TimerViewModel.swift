//
//  TimerViewModel.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 11.12.24.
//


import SwiftUI

final class TimerViewModel: ObservableObject {
    @Published var timers: [TimerModel] = [] {
        didSet {
            saveTimers()
        }
    }
    @Published var currentTimer: TimerModel? = nil
    @Published var isInvalidInput: Bool = false
    @Published var errorMessage: String = ""
    
    private let timersKey = "savedTimers"

    init() {
        loadTimers()
    }
    
    func addTimer(title: String, hours: Int, minutes: Int, seconds: Int) {
        if !isValidTime(hours: hours, minutes: minutes, seconds: seconds) {
            errorMessage = "Please enter valid time: Hours (0-23), Minutes (0-59), Seconds (0-59)."
            isInvalidInput = true
            return
        }
        
        let newTimer = TimerModel(name: title, hours: hours, minutes: minutes, seconds: seconds)
        timers.append(newTimer)
        currentTimer = newTimer
    }
    
    func selectTimer(_ timer: TimerModel) {
        currentTimer = timer
    }
    
    func startTimer(_ timer: TimerModel) {
        timer.start()
    }
    
    func stopTimer(_ timer: TimerModel) {
        timer.stop()
    }
    
    func deleteTimer(_ timer: TimerModel) {
        timers.removeAll { $0.id == timer.id }
        if self.currentTimer?.id == timer.id {
            self.currentTimer = nil
        }
    }
    
    private func isValidTime(hours: Int, minutes: Int, seconds: Int) -> Bool {
        return hours >= 0 && hours <= 23 &&
               minutes >= 0 && minutes <= 59 &&
               seconds >= 0 && seconds <= 59
    }
    
    private func saveTimers() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(timers) {
            UserDefaults.standard.set(encoded, forKey: timersKey)
            print("save")
        }
    }
    
    private func loadTimers() {
        if let savedTimers = UserDefaults.standard.data(forKey: timersKey) {
            let decoder = JSONDecoder()
            if let loadedTimers = try? decoder.decode([TimerModel].self, from: savedTimers) {
                self.timers = loadedTimers
                print("loaded")
            }
        }
    }
}
