//
//  GetTimerUseCase.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

protocol FetchUserDefaultUseCase {
    func execute(forKey key: String) -> [TimerModel]
}

struct DefaultFetchUserDefaultUseCase: FetchUserDefaultUseCase {
    private let repository = DependencyContainer.shared.resolve(type: .closureBased, for: TimersUserDefaultsRepository.self)

    public init() {
        
    }
    
    func execute(forKey key: String) -> [TimerModel] {
        repository.fetchTimers(forKey: key)
    }
}
