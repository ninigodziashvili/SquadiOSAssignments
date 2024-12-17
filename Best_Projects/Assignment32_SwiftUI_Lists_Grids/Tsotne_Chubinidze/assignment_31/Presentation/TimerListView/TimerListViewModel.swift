//
//  TimerListViewModel.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation
import SwiftUI

final class TimerListViewModel: ObservableObject {
    @Published var timers: [TimerModel] = []
    
    private let addTimerUseCase = DependencyContainer.shared.resolve(type: .closureBased, for: AddTimerUseCase.self)
    private let removeTimerUseCase = DependencyContainer.shared.resolve(type: .closureBased, for: RemoveTimerUseCase.self)
    private let getTimersUseCase = DependencyContainer.shared.resolve(type: .closureBased, for: GetTimersUseCase.self)
    
    func addTimer(_ timer: TimerModel) {
        timers.append(timer)
        addTimerUseCase.execute(timer: timer)
    }
    
    func removeTimer(_ timer: TimerModel) {
        timers.removeAll(where: { $0.id == timer.id })
        removeTimerUseCase.execute(timer: timer)
    }
    
    func getTimers() {
        timers = getTimersUseCase.execute().sorted(by: { $0.creationDate < $1.creationDate })
    }
    
    func validateInput(hour: String, minute: String, second: String) -> Bool {
        if hour.isEmpty && minute.isEmpty && second.isEmpty {
            return false
        }
        
        let isValidHour = hour.allSatisfy { $0.isNumber }
        let isValidMinute = minute.allSatisfy { $0.isNumber }
        let isValidSecond = second.allSatisfy { $0.isNumber }
        
        return isValidHour && isValidMinute && isValidSecond
    }
}
