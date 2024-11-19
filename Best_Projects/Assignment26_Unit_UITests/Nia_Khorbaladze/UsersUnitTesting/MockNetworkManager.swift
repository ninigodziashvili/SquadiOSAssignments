//
//  MockNetworkManager.swift
//  UsersUnitTesting
//
//  Created by Nkhorbaladze on 18.11.24.
//

import XCTest
@testable import UsersTestingAssignment

class MockNetworkManager {
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        let mockData = User.jsonMock.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let userList = try decoder.decode(UserList.self, from: mockData)
            completion(userList.results)
        } catch {
            print("Error: \(error)")
        }
    }
}
