//
//  NotFollowingLiskovSubstitutionPrinciple.swift.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
class OuterClassForENcapsulation {
    /*
     -- LiskovSubstitution პრინციპის თანახმად შვილობილი კლასი არ უნდა ცვლიდეს მშობელი კლასის მეთოდებს.
     
     -- ჩვენს შემთხვევაში შვილობილი კლასი ზღუდავს მშობელი კლასის ფუნქციონალს
     
     */
    class Human {
        func readBook(_ title: String) {
            print("read book!")
        }
    }
    
    class Footballer: Human {
        private let hasTime: Bool
        
        init(hasTime: Bool) {
            self.hasTime = hasTime
        }
        
        override func readBook(_ title: String) {
            if hasTime {
                super.readBook(title)
            }
        }
    }
}
