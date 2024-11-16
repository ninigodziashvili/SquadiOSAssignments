//
//  Correct.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//


// ეს არის სწორი გზა DIP-ის გამოყენების, ამ შემთხვევაში შევქმენით NetworkServiceProtocol, პროტოკოლი, რომელიც საშუალებას აძლევს NetworkService და UserManager-ს  იყვნენ დამოკიდებული მასზე, ამ გზით UserManager ეყრდნობა აბსტრაქციას (NetworkServiceProtocol) და არა იმპლემენტაციას, ამ მიდგომით გატესტვა, ჩანაცვლება, უფრო მარტივია და მოსახერხებელი ჩვენთვის

protocol NetworkServiceProtocol {
    func fetchData(completion: (String) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchData(completion: (String) -> Void) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    func fetchData(completion: (String) -> Void) {
    }
}

class UserManager {
    private let networkService: NetworkServiceProtocol 
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getUserData() {
        networkService.fetchData { data in
        }
    }
}
