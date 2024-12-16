//
//  ViewModel.swift
//  31. SwiftUI Navigation
//
//  Created by Despo on 13.12.24.
//

import SwiftUI
import Combine
import AVFoundation
import izziDateFormatter

class ViewModel: ObservableObject {
    private let izziFormater: IzziDateFormatterProtocol
    var audioPlayer: AVAudioPlayer?
    private var timerCancellables: [UUID: AnyCancellable] = [:]
    private var feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var activityDurationCount = 0
    
    @Published var timersArray: [TimerModel] = [
        TimerModel(name: "ძილი", duration: 5, defaultDuration: 5,  isStarted: false),
    ] {
        didSet {
            saveTimers()
        }
    }
    
    init(izziFormater: IzziDateFormatterProtocol = IzziDateFormatter())
    {
        self.izziFormater = izziFormater
        self.loadTimers()
    }
    
    func startTimer(for timer: TimerModel) {
        guard let index = timersArray.firstIndex(where: { $0.id == timer.id }) else { return }
        
        feedbackGenerator.prepare()
        
        timersArray[index].isStarted = true
        
        if timersArray[index].duration == 0 {
            timersArray[index].duration = timer.defaultDuration
        }
        
        timerCancellables[timer.id]?.cancel()
        timerCancellables[timer.id] = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                if let index = self?.timersArray.firstIndex(where: { $0.id == timer.id }) {
                    if self?.timersArray[index].duration ?? 0 > 0 {
                        self?.timersArray[index].duration -= 1
                        self?.activityDurationCount += 1
                    } else {
                        self?.playAudio()
                        self?.feedbackGenerator.impactOccurred()
                        print("🔴 feedbackGenerator.impactOccurred()")
                        self?.stopTimer(for: timer)
                        self?.timersArray[index].isPaused = false
                    }
                }
            }
    }
    
    func stopTimer(for timer: TimerModel) {
        if let index = timersArray.firstIndex(where: { $0.id == timer.id }) {
            addActivityToTimer(with: index)
            activityDurationCount = 0

            timersArray[index].isStarted = false
            timersArray[index].isPaused = true
            timerCancellables[timer.id]?.cancel()
        }
    }
    
    func resetTimer(for timer: TimerModel) {
        if let index = timersArray.firstIndex(where: { $0.id == timer.id }) {
//            addActivityToTimer(with: index)
            activityDurationCount = 0

            timersArray[index].duration = timer.defaultDuration
            timersArray[index].isStarted = false
            timersArray[index].isPaused = false
            timerCancellables[timer.id]?.cancel()
        }
    }
    
    func removeTimer(for timer: TimerModel) {
        if let index = timersArray.firstIndex(where: { $0.id == timer.id }) {
            timerCancellables[timer.id]?.cancel()
            timersArray.remove(at: index)
        }
    }
    
    func addTimer(name: String, hh: String, mm: String, ss: String) {
        let validHours = Int(hh) ?? 0
        let validMinutes = Int(mm) ?? 0
        let validSeconds = Int(ss) ?? 0
        
        let hours = validHours * 3600
        let minutes = validMinutes * 60
        let interval = hours + minutes + validSeconds
        
        let currentTimer = TimerModel(
            name: name,
            duration: TimeInterval(interval),
            defaultDuration: TimeInterval(interval),
            isStarted: false
        )
        
        timersArray.append(currentTimer)
    }
    
    func addActivityToTimer(with index: Int) {
        let currentDateISO = ISO8601DateFormatter().string(from: Date.now)
        let formattedDate = izziFormater.isoTimeFormatter(
            currentDate: currentDateISO,
            finalFormat: "dd MMM yyyy",
            timeZoneOffset: 4,
            localeIdentifier: "ka_GE"
        )
        
        let activity = ActivityModel(date: formattedDate, activeDuration: TimeInterval(activityDurationCount))
        
        timersArray[index].activity.append(activity)
    }
    
    func playAudio() {
        guard let audioFilePath = Bundle.main.path(forResource: "timeOver", ofType: "mp3") else {
            print("Audio file not found")
            return
        }
        
        let audioURL = URL(fileURLWithPath: audioFilePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        } catch {
            print("Failed to initialize audio player: \(error.localizedDescription)")
        }
    }
    
    func saveTimers() {
        if let encodedTimer = try? JSONEncoder().encode(timersArray) {
            UserDefaults.standard.set(encodedTimer, forKey: "timers")
        }
    }
    
    private func loadTimers() {
        if let savedTimers = UserDefaults.standard.data(forKey: "timers"),
           var decodedTimers = try? JSONDecoder().decode([TimerModel].self, from: savedTimers) {
            decodedTimers = decodedTimers.map { timer in
                var updatedTimer = timer
                updatedTimer.isStarted = false
                return updatedTimer
            }
            timersArray = decodedTimers
        }
    }
}
