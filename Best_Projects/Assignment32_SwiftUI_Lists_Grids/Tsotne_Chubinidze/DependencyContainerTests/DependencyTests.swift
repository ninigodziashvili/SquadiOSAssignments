//
//  DependencyTests.swift
//  DependencyTests
//
//  Created by Cotne Chubinidze on 13.12.24.
//

import XCTest
@testable import assignment_31

final class DependencyContainerTests: XCTestCase {

    func test_single_instance_registration() {
        let myInstance = SingleInstanceDependency()
        DependencyContainer.shared.register(type: .singleInstance(myInstance), for: SingleInstanceDependencyProtocol.self)
        
        let resolved = DependencyContainer.shared.resolve(type: .singleInstance, for: SingleInstanceDependencyProtocol.self)
        
        XCTAssertTrue(myInstance === resolved)
    }
    
    func test_closure_registration() {
        let instanceProvidingClosure: () -> ClosureDependencyProtocol = {
            ClosureDependency()
        }
        
        DependencyContainer.shared.register(type: .closureBased(instanceProvidingClosure), for: ClosureDependencyProtocol.self)
        
        let _ = DependencyContainer.shared.resolve(type: .closureBased, for: ClosureDependencyProtocol.self)
    }
    
    
}
