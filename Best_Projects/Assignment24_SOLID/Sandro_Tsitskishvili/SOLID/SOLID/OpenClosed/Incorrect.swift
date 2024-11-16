//
//  Incorrect.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ამ მაგალითში გვაქვს DiscountCalculator რომელსაც აქვს ფუნქცია calculateDiscount, ყოველი ახალი პროდუქტის დამატების შემდეგ ამ მეთოდის მოდიფიკაცია უნდა მოვახდინოთ რათა შეძლოს ამ ნივთის ფასდაკლების გამოთვლა, ასეთი მიდგომა ცალსახად არღვევს Open/Closed პრინციპს, სვიჩ ქეისების გაზრდასთან ერთად იზრდება რისკი ბაგების წარმოშობის*/

enum ProductType {
    case console
    case personalComputer
    case laptop
}

class DiscountCalculator {
    func calculateDiscount(for productType: ProductType, price: Double) -> Double {
        switch productType {
        case .console:
            return price * 0.1
        case .personalComputer:
            return price * 0.2
        case .laptop:
            return price * 0.3
        }
    }
}

