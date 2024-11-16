//
//  NotFollowingSingleResponsibilityPrinciple.swift.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
import Foundation
/*
 -- რეგისტრაციის კლასი საკუთარ თავზე იღებს რამდენიმე პასუხისმგებლობას,
 
 -- SRP-ის თანახმად კლასს მხოლოდ ერთი მიზეზი უნდა ჰქონდეს შესაცვლელად,
 
 -- ჩვენს შემთხვევაში კლასს მოუწევს შეცვლა თუ შემოწმების ან შენახვის ლოგიკაში მოგვინდება ცვლილების შეტანა,
 
 -- ეს ყველაფერი ართულებს კოდის სამომავლო მოვლას, maintanance-ს და ტესტირებადობას.
 */
final class BadRegistrationHandler {
    
    private func registerUser(username: String, password: String) {
        if checkUsername(username) && checkPassword(password) {
            saveData(username)
        }
    }
    
    private func checkPassword(_ password: String) -> Bool {
        password != ""
    }
    
    private func checkUsername(_ username: String) -> Bool {
        username != ""
    }
    
    private func saveData(_ mockUsername: String) {
        UserDefaults.standard.set(mockUsername, forKey: "username")
    }
}
