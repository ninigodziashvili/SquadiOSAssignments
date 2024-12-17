//
//  DefaultTimerRepository.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

final class DefaultTimerRepository: TimerRepository {
    private var timers: [TimerModel] = []
    private var defaults = DependencyContainer.shared.resolve(type: .closureBased, for: TimersUserDefaultsRepository.self)
    
    public init() {
        
    }
    
    func getTimers() -> [TimerModel] {
        let timers = defaults.fetchTimers(forKey: "timers")
        self.timers = timers
        return timers
    }
    
    func addTimer(_ timer: TimerModel) {
        timers.append(timer)
        defaults.saveTimers(key: "timers", timers: timers)
    }
    
    func removeTimer(_ timer: TimerModel) {
        timers.removeAll { $0.id == timer.id }
        defaults.saveTimers(key: "timers", timers: timers)
    }
    
    func logTimerUse(_ timer: TimerModel) {
        timers.removeAll { $0.id == timer.id }
        timers.append(timer)
        defaults.saveTimers(key: "timers", timers: timers)
    }
}

