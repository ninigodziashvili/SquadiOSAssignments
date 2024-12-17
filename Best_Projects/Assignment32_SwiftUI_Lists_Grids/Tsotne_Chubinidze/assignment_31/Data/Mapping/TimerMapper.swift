//
//  TimerMapper.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 14.12.24.
//
import Foundation

struct TimerMapper {
    
    static func encodeTimers(_ timers: [TimerModel]) -> Data {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(timers)
            return encodedData
        } catch {
            print(error.localizedDescription)
            return Data()
        }
    }
    
    static func decodeTimers(from data: Data) -> [TimerModel] {
        let decoder = JSONDecoder()
        do {
            let decodedTimers = try decoder.decode([TimerModel].self, from: data)
            return decodedTimers
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
