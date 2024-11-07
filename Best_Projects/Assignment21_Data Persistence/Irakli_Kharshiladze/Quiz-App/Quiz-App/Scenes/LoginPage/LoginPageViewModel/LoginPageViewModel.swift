//
//  LoginPageViewModel.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 04.11.24.
//

import Foundation

final class LoginPageViewModel {
    
    var onLoginSuccess: (() -> Void)?
    var onPasswordMismatch: ((String) -> Void)?
    
    func saveUser(userName: String, passWord: String, confirmPassword: String) {
        guard !userName.isEmpty else {
            print("Username is empty")
            return
        }
        
        guard passWord == confirmPassword else {
            print("Passwords don't match")
            onPasswordMismatch?("Passwords don't match")
            return
        }
        
        do {
            guard let passwordData = passWord.data(using: .utf8) else {
                print("Error converting password to data")
                return
            }
            
            try KeyChainManager.save(
                service: "Quiz.app",
                account: userName,
                password: passwordData
            )
            
            UserDefaults.standard.set(userName, forKey: "username")
            onLoginSuccess?()
        } catch {
            print("Error saving user: \(error)")
        }
    }
}

