//
//  FollowingLiskovSubstitutionPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
class OuterClassForENcapsulation1 {
    /*
     -- სწორ შემთხვევაში მშობელ კლასშივე არის გათვალისწინებული შეზღუდვა და ამიტომ
     LiskovSubstitution პრინციპი არ ირღვევა
     
     -- შვილობილი კლასი არ ზღუდავს მშობელი კლასის ფუნქციონალს
     */
    class Human {
        private let hasTime: Bool
        
        init(hasTime: Bool) {
            self.hasTime = hasTime
        }
        
        func readBook(_ title: String) {
            if hasTime {
                print("read book!")
            }
        }
    }
    
    class Footballer: Human {
        override func readBook(_ title: String) {
            super.readBook(title)
        }
    }
}
