//
//  LIkovSubstitution.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 14.11.24.
//

import UIKit

class LIkovSubstitution {
    
    /* მოცემულ კოდში უზრუნველყოფილია LSP პრინციპი შვილობილი
     კლასები იღებენ მშობლის კლასს ფუნქციას და გააჩნიათ საკუთარი
     იპლემენტაცია- მოქმედების თავისებურება.*/
    
    class Bird {
        func makeSound() {
            print("The bird makes a sound.")
        }
    }
    
    class Chiken: Bird {
        override func makeSound() {
            print("Cococo")
        }
    }
    
    class Penguin: Bird {
        override func makeSound() {
            print("Plu Plu")
        }
    }
    
    let birds: [Bird] = [Chiken(), Penguin()]
    
    func makingSound(){
        for bird in birds {
            bird.makeSound()
        }
    }
}
