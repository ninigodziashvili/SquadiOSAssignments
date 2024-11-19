//
//  UsersTestingTests.swift
//  UsersTestingTests
//
//  Created by Anna Harris on 18.11.24.
//

import XCTest
@testable import UsersTestingAssignment

class UsersTestingTests: XCTestCase {
    
    var mockNetworkManager: MockNetworkManager!
    var userCell: UserCell!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        let tableView = UITableView()
                tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
                userCell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        userCell = nil
        super.tearDown()
    }
    
    func testValidUserDataDecoding() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "Valid User Data Decoding")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.email, "christian.nielsen@example.com")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidDataDecoding() {
        let invalidJSON = "{ broken JSON }".data(using: .utf8)
        mockNetworkManager.mockData = invalidJSON
        
        let expectation = self.expectation(description: "Invalid Data Decoding")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list for invalid data")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmptyResponse() {
        let emptyJSON = """
        {
            "results": []
        }
        """.data(using: .utf8)
        mockNetworkManager.mockData = emptyJSON
        
        let expectation = self.expectation(description: "Empty Response")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkError() {
        mockNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "Network Error")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list in case of network error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserViewModelWithValidUser() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "UserViewModel with Valid User")
        
        mockNetworkManager.fetchUsers { users in
            let userVM = UserViewModel(user: users.first!)
            XCTAssertEqual(userVM.fullName, "Mr Christian Nielsen")
            XCTAssertEqual(userVM.email, "christian.nielsen@example.com")
            XCTAssertNotNil(userVM.thumbnailImageUrl, "Thumbnail URL should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserViewModelWithMissingImageURL() {
        let mockJSON = """
            {
                "results": [
                    {
                        "gender": "male",
                        "name": {
                            "title": "Mr",
                            "first": "Christian",
                            "last": "Nielsen"
                        },
                        "email": "christian.nielsen@example.com",
                        "cell": "85537737",
                        "phone": "57231440",
                        "nat": "DK",
                        "picture": {
                            "large": "",
                            "medium": "",
                            "thumbnail": ""
                        }
                    }
                ],
                "info": {
                    "seed": "679517541f0f3194",
                    "results": 1,
                    "page": 1,
                    "version": "1.4"
                }
            }
            """.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "UserViewModel with Missing Image URL")
        
        mockNetworkManager.fetchUsers { users in
            let userVM = UserViewModel(user: users.first!)
            
            XCTAssertNil(userVM.thumbnailImageUrl, "Thumbnail URL should be nil or empty when not provided.")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRandomUserLimit() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "Random User Limit")
        
        let randomLimit = Int.random(in: 5...100)
        mockNetworkManager.fetchUsers(withLimit: randomLimit) { users in
            XCTAssertGreaterThanOrEqual(users.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserFullName() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "User Full Name")
        
        mockNetworkManager.fetchUsers { users in
            let userVM = UserViewModel(user: users.first!)
            
            XCTAssertEqual(userVM.fullName, "Mr Christian Nielsen")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUsserViewModelWithMissingEmail() {
        let mockJSON = """
        {
          "results": [
            {
              "gender": "male",
              "name": {
                "title": "Mr",
                "first": "Christian",
                "last": "Nielsen"
              },
              "email": "",
              "picture": {
                "large": "https://randomuser.me/api/portraits/men/25.jpg",
                "medium": "https://randomuser.me/api/portraits/med/men/25.jpg",
                "thumbnail": "https://randomuser.me/api/portraits/thumb/men/25.jpg"
              },
              "nat": "DK",
              "cell": "85537737",
              "phone": "57231440"
            }
          ]
        }
        """.data(using: .utf8)
        
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "UserViewModel with Missing Email")
        
        mockNetworkManager.fetchUsers { users in
            let userVM = UserViewModel(user: users.first!)
            
            XCTAssertEqual(userVM.email, "", "Email should be empty if it's missing in the data")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserFetching() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "User Fetching")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 1, "Expected to fetch 1 user")
            
            let userVM = UserViewModel(user: users.first!)
            
            XCTAssertEqual(userVM.fullName, "Mr Christian Nielsen", "Full name should match the expected value")
            
            XCTAssertEqual(userVM.email, "christian.nielsen@example.com", "Email should match the expected value")
            
            XCTAssertEqual(userVM.contactNumber, "85537737 / 57231440", "Contact number should match the expected value")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testNetworkManagerWithValidData() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "NetworkManager with Valid Data")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 1, "Should fetch 1 user")
            XCTAssertEqual(users.first?.email, "christian.nielsen@example.com", "Email should match the expected value")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithInvalidData() {
        let invalidJSON = "{ broken JSON }".data(using: .utf8)
        mockNetworkManager.mockData = invalidJSON
        
        let expectation = self.expectation(description: "NetworkManager with Invalid Data")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list for invalid data")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithEmptyResponse() {
        let emptyJSON = """
        {
            "results": []
        }
        """.data(using: .utf8)
        mockNetworkManager.mockData = emptyJSON
        
        let expectation = self.expectation(description: "NetworkManager with Empty Response")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithNetworkError() {
        mockNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "NetworkManager with Network Error")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list in case of network error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithRandomUserLimit() {
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "NetworkManager with Random User Limit")
        
        let randomLimit = Int.random(in: 5...100)
        mockNetworkManager.fetchUsers(withLimit: randomLimit) { users in
            XCTAssertGreaterThanOrEqual(users.count, 1, "Expected to fetch at least 1 user")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithHTTPStatusCode404() {
        _ = NSError(domain: "", code: 404, userInfo: nil)
        mockNetworkManager.shouldReturnError = true

        let expectation = self.expectation(description: "NetworkManager with 404 Status Code")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return empty user list for 404 error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }


    func testNetworkManagerWithZeroUserLimit() {
        let mockJSON = """
        {
            "results": []
        }
        """.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "NetworkManager with Zero User Limit")
        
        mockNetworkManager.fetchUsers(withLimit: 0) { users in
            XCTAssertEqual(users.count, 0, "Should return an empty list when the limit is 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithDelay() {
        mockNetworkManager.shouldReturnError = false
        
        let mockJSON = User.jsonMock.data(using: .utf8)
        mockNetworkManager.mockData = mockJSON
        
        let expectation = self.expectation(description: "NetworkManager with Delay")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.mockNetworkManager.fetchUsers { users in
                XCTAssertEqual(users.count, 1, "Expected to fetch 1 user after delay")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkManagerWithTimeout() {
        mockNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "NetworkManager with Timeout")
        
        mockNetworkManager.fetchUsers { users in
            XCTAssertEqual(users.count, 0, "Should return an empty user list in case of timeout")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }


}

