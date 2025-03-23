//
//  Untitled.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 15.12.24.
//
import Foundation

protocol LogTimerUseCase {
    func execute(_ timer: TimerModel)
}

struct DefaultLogTimerUseCase: LogTimerUseCase {
    private let repository = DependencyContainer.shared.resolve(type: .singleInstance, for: TimerRepository.self)
    
    public init() {
        
    }
    
    func execute(_ timer: TimerModel) {
        repository.logTimerUse(timer)
    }
}
