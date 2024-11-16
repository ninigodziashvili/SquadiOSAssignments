//
//  Incorrect.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

// ამ მაგალითში DIP დაცული არ არის, UserManager პირდაპირ არის დამოკიდებული NetworkService-ზე, რაც იწვევს მათ მჭიდრო კავშირს, შესაბამისად NetworkService - ის გატესტვა ან ჩანაცვლება რთული იქნება 

class NetworkService {
    func fetchData(completion: (String) -> Void) {
    }
}

class UserManager {
    private let networkService = NetworkService()
    
    func getUserData() {
        networkService.fetchData { data in
        }
    }
}
