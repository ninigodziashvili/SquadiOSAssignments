//
//  FollowingSingleResponsibilityPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
import Foundation
/*
 -- თითო კლასს აკისრია თითო პასუხისმგებლობა რაც აუმჯობესებს ტესტირებას,
 
 -- აადვილებს mock data-ს ჩასმას, გვაძლევს მეტ მოქნილობას შევცვალოთ კალსები ისე რომ
 არ შევეხოთ სხვა კლასებს, მაგალითად შემოვიტანოთ პაროლის შმეოწმების უფრო დახვეწილი ლოგიკა.
 
 -- კლასები ხდებიან reusable რადგან ისინი ერთამნეთისგან დამოუკიდებელი ობიექტებია.
 
 -- ამ ყველაფრიდან გამომდინარე იზრდება maintainability.
 
 */
protocol Checkable {
    func check(_ mockData: String) -> Bool
}

protocol Saveable {
    func saveData(_ mockData: String)
}

final class BetterRegistrationHandler {
    private let passwordChecker: Checkable
    private let usernameChecker: Checkable
    private let userInfoSaver: Saveable
    
    init(passwordChecker: Checkable, usernameChecker: Checkable, userInfoSaver: Saveable) {
        self.passwordChecker = passwordChecker
        self.usernameChecker = usernameChecker
        self.userInfoSaver = userInfoSaver
    }
    
    private func registerUser(username: String, password: String) {
        if passwordChecker.check(password) && usernameChecker.check(username) {
            userInfoSaver.saveData(username)
        }
    }
}

final class UsernameChecker: Checkable {
    func check(_ username: String) -> Bool {
        username != ""
    }
}

final class PasswordChecker: Checkable {
    func check(_ password: String) -> Bool {
        password != ""
    }
}

final class UserInfoSaver: Saveable {
    func saveData(_ mockUsername: String) {
        UserDefaults.standard.set(mockUsername, forKey: "mockUsername")
    }
}
