//
//  InterfaceSegregation.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 14.11.24.
//

import Foundation

protocol Depositable {
    func deposit(amount: Double)
}

protocol Withdrawable {
    func withdraw(amount: Double)
}

protocol PercentCalculable {
    func calculateInterest()
}

protocol BillPayable {
    func payBills()
}

class InterfaceSegregation {
    
/* მოცემული მაგალითი გვიჩვენებს InterfaceSegragation ის პრინციპის
     მნიშვნელობას. მოცემულ მაგალითში თითოეული კლასს აქვს შესაბამისი ფუნქციონალი
 რომელსაც პროტოკოლის საშუალებით იღებს. ამიტომ არსობრივად შესაბამისია და უზრუნველყოფს მხოლოდ საჭირო
 მოქმედებებს.
 
*/
    class CheckingAccount: Depositable, Withdrawable, BillPayable {
        func deposit(amount: Double) {
            print("Depositing \(amount) into checking account")
        }
        
        func withdraw(amount: Double) {
            print("Withdrawing \(amount) from checking account")
        }
        
        func payBills() {
            print("Paying bills using checking account")
        }
    }
    
    class SavingsAccount: Depositable, Withdrawable, PercentCalculable {
        func deposit(amount: Double) {
            print("Depositing \(amount) into the account")
        }
        
        func withdraw(amount: Double) {
            print("Withdrawing \(amount) from saved account")
        }
        
        func calculateInterest() {
            print("Calculating interest for savings account")
        }
    }
}
