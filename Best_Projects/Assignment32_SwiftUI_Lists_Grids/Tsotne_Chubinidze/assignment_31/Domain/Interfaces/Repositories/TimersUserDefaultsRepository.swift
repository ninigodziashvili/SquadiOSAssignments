//
//  TimerUserDefaultsRepository.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
protocol TimersUserDefaultsRepository {
    func saveTimers(key: String, timers: [TimerModel])
    func fetchTimers(forKey key: String) -> [TimerModel]
}
