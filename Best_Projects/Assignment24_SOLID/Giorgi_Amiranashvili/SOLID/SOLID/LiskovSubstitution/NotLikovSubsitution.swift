//
//  NotLikovSubsitution.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 14.11.24.
//

import Foundation

class NotLikovSubsitution {
    
/* მოცემულ კოდში შვილობილი კლასი მშობელი კლასის ფუნქციას არ ითავსებს
 რაც დაუშვებელია LikovSubsitution ის პრინციპით. ასეთ შემთხვევებში კოდი
 ხდება არათანმიმდევრული და არღვევს კლასის ძირითად თვისებას გაფართოვდეს მათივე ქცევის
 შეძვლის გარეშე.
 */
    
    class Bird {
        func fly() {
            print("The bird is flying.")
        }
    }

    class Penguin: Bird {
        override func fly() {
            fatalError("Penguins can't fly!")
        }
    }

    let bird: Bird = Penguin()
    
    func birdFlying() {
        bird.fly()
    }
}
