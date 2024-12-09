//
//  MockNetworkManager.swift
//  UsersTestingTests
//
//  Created by Anna Harris on 18.11.24.
//

import XCTest
@testable import UsersTestingAssignment

class MockNetworkManager: NSObject {
    var mockData: Data?
    var shouldReturnError: Bool = false
    
    public override init() {
        super.init()
    }

     func fetchUsers(withLimit limit: Int = 1, completionHandler: @escaping ([User]) -> Void) {
        if shouldReturnError {
            completionHandler([])
        } else if let data = mockData {
            do {
                let userList = try JSONDecoder().decode(UserList.self, from: data)
                completionHandler(userList.results)
            } catch {
                completionHandler([])
            }
        }
    }
}


