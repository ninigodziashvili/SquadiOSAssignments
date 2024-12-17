//
//  RemoveTimerUseCase.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

protocol RemoveTimerUseCase {
    func execute(timer: TimerModel)
}

struct DefaultRemoveTimerUseCase: RemoveTimerUseCase {
    private let repository = DependencyContainer.shared.resolve(type: .singleInstance, for: TimerRepository.self)
    
    public init() {
      
    }

    func execute(timer: TimerModel) {
        repository.removeTimer(timer)
    }
}
