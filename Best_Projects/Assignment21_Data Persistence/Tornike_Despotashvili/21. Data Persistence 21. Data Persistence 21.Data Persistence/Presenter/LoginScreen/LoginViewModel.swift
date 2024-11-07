//
//  Login_ViewModel.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 02.11.24.
//

import UIKit

final class LoginViewModel: UIViewController {
    func auth(userField: PaddedTextField, passField: PaddedTextField, confield: PaddedTextField, errors: (String?) -> Void) {
        guard userField.text?.count ?? 0 > 1 else {
            errors("Username must not be empty")
            return
        }
        
        guard passField.text?.count ?? 0 > 5 else {
            errors("Password must be at least 6 characters")
            return
        }
        
        if (passField.text == confield.text) {
            do {
                try KeyChainVC.shared.save(service: "quizapp", account: userField.text ?? "", password: passField.text?.data(using: .utf8) ?? Data())
                UserDefaults.standard.setValue(userField.text, forKey: "userName")
            } catch KeyChainVC.keyChainError.duplicate {
                errors("This user already exists")
            } catch {
                print(error.localizedDescription)
            }
        } else {
            errors("The Passwords do not match")
        }
    }
}
