//
//  TimerRepository.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

protocol TimerRepository: AnyObject {
    func addTimer(_ timer: TimerModel)
    func removeTimer(_ timer: TimerModel)
    func getTimers() -> [TimerModel]
    func logTimerUse(_ timer: TimerModel)
}
