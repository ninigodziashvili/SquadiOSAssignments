//
//  NoInerfaceSegregation.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 14.11.24.
//

import Foundation
/*
 მოცემული მაგალითი არღვევს InterfaceSegregation ის პრინციპს:
 CheckingAccount და SavingsAccount იძულებულნი არიან ჰქონდეთ მეთოდები,
 რომლებიც შეიძლება არ იყოს შესაბამისი მათ არსთან.
 CheckingAccount-ს არ უნდა ჰქონდეს პროცენტის გაანგარიშების
 ან გადასახადების გადახდის ფუნქციონალისთვის საჭირო მხარდაჭერა
 */


protocol BankAccount {
    func deposit(amount: Double)
    func withdraw(amount: Double)
    func calculatePercent()
    func payBills()
}

class CheckingAccount: BankAccount {
    
    func deposit(amount: Double) {
        print("Deposit \(amount) into the account")
    }
    
    func withdraw(amount: Double) {
        print("Withdrawing \(amount) from account")
    }
    // აღნიშნული ფუნქციონალი კლასის შინაარსთან შეუსაბამოა
    func calculatePercent() {
        
    }
    
    func payBills() {
        print("Paying bills using checking account")
    }
}

class SavingsAccount: BankAccount {
    
    func deposit(amount: Double) {
        print("Depositing \(amount) into savings account")
    }
    
    func withdraw(amount: Double) {
        print("Withdrawing \(amount) from savings account")
    }
    
    func calculatePercent() {
        print("Calculating interest for savings account")
    }
    // აღნიშნული ფუნქციონალი კლასის შინაარსთან შეუსაბამოა
    func payBills() {

    }
}
