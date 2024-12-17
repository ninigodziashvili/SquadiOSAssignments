//
//  StartTimerUseCase.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

protocol UpdateUserDefaultUseCase {
    func execute(key: String, timers: [TimerModel])
}

struct  DefaultUpdateUserDefaultUseCase: UpdateUserDefaultUseCase  {
    private let repository = DependencyContainer.shared.resolve(type: .closureBased, for: TimersUserDefaultsRepository.self)
    
    public init() {
        
    }
    
    func execute(key: String, timers: [TimerModel]) {
        repository.saveTimers(key: key, timers: timers)
    }
}
