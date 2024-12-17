//
//  AppConfigurer.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation

enum AppConfigurer {
    private static var didConfigureDependencies = false
    static func configureDependencies() {
        guard didConfigureDependencies == false else {
            assertionFailure("dependencies should only be configured once")
            return
        }
        
        didConfigureDependencies = true
        
        DependencyContainer.shared.register(type: .closureBased { DefaultTimersUserDefaultsRepository() }, for: TimersUserDefaultsRepository.self)
        
        DependencyContainer.shared.register(type: .singleInstance(DefaultTimerRepository()), for: TimerRepository.self)
        
        DependencyContainer.shared.register(type: .closureBased { DefaultUpdateUserDefaultUseCase() }, for: UpdateUserDefaultUseCase.self)
        
        DependencyContainer.shared.register(type: .closureBased { DefaultAddTimerUseCase() }, for: AddTimerUseCase.self)
        
        DependencyContainer.shared.register(type: .closureBased { DefaultRemoveTimerUseCase() }, for: RemoveTimerUseCase.self)
        
        DependencyContainer.shared.register(type: .closureBased { DefaultGetTimersUseCase() }, for: GetTimersUseCase.self)
        
        DependencyContainer.shared.register(type: .closureBased { DefaultLogTimerUseCase() }, for: LogTimerUseCase.self)
        
        DependencyContainer.shared.register(type: .closureBased { DefaultFetchUserDefaultUseCase() }, for: FetchUserDefaultUseCase.self)
    }
}
