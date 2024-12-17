//
//  UpdateTimerStateUserCase.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

protocol GetTimersUseCase {
    func execute() -> [TimerModel]
}

struct DefaultGetTimersUseCase: GetTimersUseCase {
    private let repository = DependencyContainer.shared.resolve(type: .singleInstance, for: TimerRepository.self)
    
    public init() {
        
    }
    
    func execute() -> [TimerModel] {
        repository.getTimers()
    }
}
