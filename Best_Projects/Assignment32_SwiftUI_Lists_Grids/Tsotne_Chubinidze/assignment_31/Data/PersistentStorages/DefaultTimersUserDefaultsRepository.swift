//
//  DefaultUserDefaultsRepository.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

struct DefaultTimersUserDefaultsRepository: TimersUserDefaultsRepository {
    
    private let userDefaults = UserDefaults.standard
    
    func saveTimers(key: String, timers: [TimerModel]) {
        DispatchQueue.global(qos: .background).sync {
            let encodedTimers = TimerMapper.encodeTimers(timers)
            userDefaults.set(encodedTimers, forKey: key)
            userDefaults.synchronize()
        }
    }
        
    func fetchTimers(forKey key: String) -> [TimerModel] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {
            print("error, coukld not decode data as TimerModel")
            return []
        }
        let timers = TimerMapper.decodeTimers(from: data)
        return timers
    }
}
