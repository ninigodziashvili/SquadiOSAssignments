//
//  TimerViewModel.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//
import SwiftUI
import Combine
import AVFoundation
import AudioToolbox

final class TimerViewModel: ObservableObject {
    @Published var timers: [TimerModel] = []
    @Published var QuickTimers: [TimerModel] = [
        TimerModel(name: "ჩაის დაყენება", duration: 180, defaultDuration: 180),
        TimerModel(name: "HIIT ვარჯიში", duration: 420, defaultDuration: 420),
        TimerModel(name: "კვერცხის მოხარშვა", duration: 600, defaultDuration: 600),
        TimerModel(name: "შესვენება", duration: 900, defaultDuration: 900),
        TimerModel(name: "ყავის პაუზა", duration: 1200, defaultDuration: 1200),
        TimerModel(name: "პომოდორო", duration: 1500, defaultDuration: 1500),
        TimerModel(name: "მედიტაცია", duration: 1800, defaultDuration: 1800),
        TimerModel(name: "ვარჯიში", duration: 2700, defaultDuration: 2700),
        TimerModel(name: "სამუშაო სესია", duration: 3600, defaultDuration: 3600),
        TimerModel(name: "დასუფთავება", duration: 600, defaultDuration: 600),
        TimerModel(name: "წაკითხვა", duration: 1200, defaultDuration: 1200),
        TimerModel(name: "ვარჯიში 2", duration: 1800, defaultDuration: 1800),
        TimerModel(name: "დაჭერილობა", duration: 2400, defaultDuration: 2400),
        TimerModel(name: "მუშაობა პროექტზე", duration: 3600, defaultDuration: 3600),
        TimerModel(name: "დაძინება", duration: 7200, defaultDuration: 7200),
        TimerModel(name: "დასვენება 2", duration: 1500, defaultDuration: 1500),
        TimerModel(name: "ჰობი", duration: 900, defaultDuration: 900),
        TimerModel(name: "საუზმე", duration: 1800, defaultDuration: 1800),
        TimerModel(name: "ფილმების ყურება", duration: 2400, defaultDuration: 2400)
    ]

    @AppStorage("Timers") private var storedTimersData: Data?
    
    private var timerCancellables: [UUID: AnyCancellable] = [:]
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        loadTimersFromAppStorage()
    }
    
    func addTimer(name: String, hours: String, minutes: String, seconds: String) {
        let hoursValue = Int(hours) ?? 0
        let minutesValue = Int(minutes) ?? 0
        let secondsValue = Int(seconds) ?? 0
        
        let totalInterval = hoursValue * 3600 + minutesValue * 60 + secondsValue
        guard totalInterval > 0 else {
            print("Cannot add a timer with zero duration.")
            return
        }
        
        let timer = TimerModel(name: name, duration: TimeInterval(totalInterval), defaultDuration: TimeInterval(totalInterval))
        timers.append(timer)
        saveTimersToAppStorage()
    }
    
    func addQuickTimer(timer: TimerModel) {
        timers.append(timer)
        saveTimersToAppStorage()
    }
    
    func removeTimer(with id: UUID) {
        timers.removeAll(where: { $0.id == id })
        saveTimersToAppStorage()
    }
    
    func startTimer(with timer: TimerModel) {
        guard let index = timers.firstIndex(where: { $0.id == timer.id }) else { return }
        timers[index].isRunning = true
        timers[index].startDate = Date()
        
        if timers[index].duration == 0 {
            timers[index].duration = timer.defaultDuration
        }
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                if self?.timers[index].duration ?? 0 > 0 {
                    self?.timers[index].duration -= 1
                } else {
                    self?.playEndSounAndVibrate()
                    self?.resetTimer(with: timer)
                }
            }
    }
    
    func pauseTimer(with timer: TimerModel) {
        guard let index = timers.firstIndex(where: { $0.id == timer.id }) else { return }
        timers[index].isRunning = false
        
        updateHistory(for: &timers[index])
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = nil
    }
    
    func resetTimer(with timer: TimerModel) {
        guard let index = timers.firstIndex(where: { $0.id == timer.id }) else { return }
        timers[index].isRunning = false
        
        updateHistory(for: &timers[index])
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = nil
        timers[index].duration = timer.defaultDuration
    }
    
    private func updateHistory(for timer: inout TimerModel) {
        guard let startDate = timer.startDate else { return }
        let endTime = Date()
        let elapsed = endTime.timeIntervalSince(startDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ka_GE")
        dateFormatter.dateFormat = "dd MMM yyyy"
        let today = dateFormatter.string(from: Date())
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ka_GE")
        timeFormatter.dateFormat = "HH:mm"
        let startTimeString = timeFormatter.string(from: startDate)
        let endTimeString = timeFormatter.string(from: endTime)
        
        let session = HistoryEntry.Session(
            startTime: startTimeString,
            endTime: endTimeString,
            duration: elapsed - 1
        )
        
        if let index = timer.history.firstIndex(where: { $0.date == today }) {
            timer.history[index].sessions.append(session)
        } else {
            let newEntry = HistoryEntry(date: today, sessions: [session])
            timer.history.append(newEntry)
        }
        
        timer.startDate = nil
        if let timerIndex = timers.firstIndex(where: { $0.id == timer.id }) {
            timers[timerIndex] = timer
            timers[timerIndex].duration = timer.defaultDuration
            saveTimersToAppStorage()
        }
    }
    
    func playEndSounAndVibrate() {
        guard let url = Bundle.main.url(forResource: "timerEnd", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error)")
        }
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private func loadTimersFromAppStorage() {
        if let savedData = storedTimersData,
           let savedTimers = try? JSONDecoder().decode([TimerModel].self, from: savedData) {
            timers = savedTimers
        }
    }
    
    private func saveTimersToAppStorage() {
        if let encodedTimers = try? JSONEncoder().encode(timers) {
            storedTimersData = encodedTimers
        }
    }
}
