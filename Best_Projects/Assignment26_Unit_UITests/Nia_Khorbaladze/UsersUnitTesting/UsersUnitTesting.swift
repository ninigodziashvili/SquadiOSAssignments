//
//  UsersUnitTesting.swift
//  UsersUnitTesting
//
//  Created by Nkhorbaladze on 18.11.24.
//

import XCTest
@testable import UsersTestingAssignment

final class UsersUnitTesting: XCTestCase {
    var user: User?
    var testHelper: TestHelper?
    var mockNetworkManager: MockNetworkManager?
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        testHelper = TestHelper()
    }

    override func tearDownWithError() throws {
        mockNetworkManager = nil
        user = nil
    }

    func testName() {
        mockNetworkManager?.fetchUsers { users in
            guard let user = users.first else {
                XCTFail("User data is nil")
                return
            }
            let viewModel = UserViewModel(user: user)
            
            let name = viewModel.fullName
            XCTAssertEqual(name, "\(user.name.title) \(user.name.first) \(user.name.last)")
        }
    }
    
    func testEmail() {
        mockNetworkManager?.fetchUsers { users in
            guard let user = users.first else {
                XCTFail("User data is nil")
                return
            }
            let viewModel = UserViewModel(user: user)
            
            let email = viewModel.email
            XCTAssertEqual(email, "christian.nielsen@example.com")
        }
    }
    
    func testContactNumber() {
        mockNetworkManager?.fetchUsers { users in
            guard let user = users.first else {
                XCTFail("User data is nil")
                return
            }
            let viewModel = UserViewModel(user: user)
            
            let number = viewModel.contactNumber
            XCTAssertEqual(number, "\(user.cell) / \(user.phone)")
        }
    }
    
    func testImageURL() {
        mockNetworkManager?.fetchUsers { users in
            guard let user = users.first else {
                XCTFail("User data is nil")
                return
            }
            let viewModel = UserViewModel(user: user)
            
            let imageURL = viewModel.thumbnailImageUrl
            XCTAssertNotNil(imageURL)
        }
    }
    
    func testFailureForIncorrectJSON() {
        guard let data = testHelper?.incorrectJson.data(using: .utf8) else {
            return
        }
        
        do {
            let decode = try JSONDecoder().decode(UserList.self, from: data)
            XCTAssertFalse(decode.results.isEmpty)
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func testFailureForEmptyJSON() {
        guard let data = testHelper?.emptyJson.data(using: .utf8) else {
            return
        }
        
        do {
            let decode = try JSONDecoder().decode(UserList.self, from: data)
            XCTAssertNotNil(decode)
            XCTAssertTrue(decode.results.isEmpty)
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testFailureForMissingFieldsJson() {
        guard let data = testHelper?.missingFieldsJson.data(using: .utf8) else {
            return
        }
        
        do {
            let decode = try JSONDecoder().decode(UserList.self, from: data)
            guard let user = decode.results.first else {
                return
            }
            
            let viewModel = UserViewModel(user: user)
            
            XCTAssertEqual(viewModel.fullName, "Mr Christian")
            XCTAssertNil(viewModel.thumbnailImageUrl, "Image is missing")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testEmptyStringForPhoneNumberJson() {
        guard let data = testHelper?.emptyStringForContactNumberJson.data(using: .utf8) else {
            return
        }
        
        do {
            let decode = try JSONDecoder().decode(UserList.self, from: data)
            guard let user = decode.results.first else {
                return
            }
            
            let viewModel = UserViewModel(user: user)
            
            XCTAssertEqual(viewModel.contactNumber, "/")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
}
