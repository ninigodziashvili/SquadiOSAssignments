//
//  KeyChainVC.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 03.11.24.
//

import UIKit

class KeyChainVC: UIViewController {
    
    static let shared = KeyChainVC()
    
    enum keyChainError: Error {
        case duplicate
        case unknown
        case notFound
        case kcErrorWithCode(Int)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func save(
        service: String,
        account: String,
        password: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : service as AnyObject,
            kSecAttrAccount as String : account as AnyObject,
            kSecValueData as String : password as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw keyChainError.duplicate
        }
        
        guard status == errSecSuccess else {
            throw keyChainError.unknown
        }
    }
    
    func get(
        service: String,
        account: String
    ) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        
        SecItemCopyMatching(query as CFDictionary, &result)
        
        return result as? Data
    }
}
