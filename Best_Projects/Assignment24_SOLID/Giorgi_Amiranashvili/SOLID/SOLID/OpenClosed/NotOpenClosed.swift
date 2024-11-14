//
//  NotOpenClosed.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 13.11.24.
//

import UIKit

/*
// მოცემულ მაგალითში არის ფასის დათვლის ლოგიკა
 სადაც დარღვეულია OpenClosed პრინციპი. თითოეული პროდუქტის დამატების შემთხვევაში
  გვიწევს DiscountCalculator კლასის შეცვლა. გარდა ამისა აღნიშნული შემთხვევა მნიშვნელოვნად
 გადატვირთავს complexity ს.

*/

enum Gasoline {
    case regular
    case premium
}

class Calculator {
    func calculatePrice(for gasolineType: Gasoline) -> Double {
        if gasolineType == .premium {
            return 10.0
        } else if gasolineType == .regular {
            return 5.0
        }
        return 0.0
    }
}





