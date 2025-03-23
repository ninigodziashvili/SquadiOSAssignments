//
//  AddTimerUseCase.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

protocol AddTimerUseCase {
    func execute(timer: TimerModel)
}

struct DefaultAddTimerUseCase: AddTimerUseCase {
    private let repository = DependencyContainer.shared.resolve(type: .singleInstance, for: TimerRepository.self)
    
    public init() {
       
    }

    func execute(timer: TimerModel) {
        repository.addTimer(timer)
    }
}

