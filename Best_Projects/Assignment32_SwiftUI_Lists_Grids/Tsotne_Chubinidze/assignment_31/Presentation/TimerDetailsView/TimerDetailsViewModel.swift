//
//  TimerDetailsViewModel.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 16.12.24.
//
import SwiftUI
import MyDateFormatter

class TimerDetailsViewModel: ObservableObject {
    @Published var timer: TimerModel
    private let dateFormatter = MyDateFormatter()

    init(timer: TimerModel) {
        self.timer = timer
    }

    func numberOfSessions() -> Int {
        let currentDate = Date()
        let currentDay = dateFormatter.formatDateOnly(currentDate)
        
        if timer.history.keys.sorted().last != currentDay {
            return 0
        } else {
            return timer.history[currentDay]?.count ?? 0
        }
    }
    
    func totalTime() -> String {
        let currentDate = Date()
        let currentDay = dateFormatter.formatDateOnly(currentDate)
        
        if timer.history.keys.sorted().last != currentDay {
            return "0 წუთი"
        } else {
            let total = timer.history[currentDay]?.reduce(into: 0, { partialResult, log in
                partialResult += log.useTimeInSeconds
            })
            return total?.asTimes.toTimeFormat() ?? "12"
        }
    }
    
    func averageDuration() -> String {
        let currentDate = Date()
        let currentDay = dateFormatter.formatDateOnly(currentDate)
        
        if timer.history.keys.sorted().last != currentDay {
            return "0 წუთი"
        } else {
            let total = timer.history[currentDay]?.reduce(into: 0, { partialResult, log in
                partialResult += log.useTimeInSeconds
            })
            guard let total = total else { return "0 წუთი" }
            guard let count = timer.history[currentDay]?.count else { return "0 წუთი" }
            let average = total / count
            return average.asTimes.toTimeFormat()
        }
    }
}
