//
//  Correct.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ამ მიდგომით ჩვენ ვქმნით პროტოკოლს Discountable და კლასებს ფასდაკლების თითოეული ტიპისთვის, ასეთ შემთხვევაში ჩვენ შეგვიძლია დავამატოთ ახალი ფასდაკლების ტიპები მარტივად ახალი კლასების შემოტანით, ამჟამინდელი კოდის შეცვლის გარეშე, ამგვარად DiscountCalculator არის ჩაკეტილი მოდიფიკაციისთვის, თუმცა ღია გაფართოებისთვის რაც პირდაპირ იცავს  open/closed პრინციპს  */

protocol Discountable {
    func calculateDiscountedPrice(for price: Double) -> Double
}

class consoleDiscount: Discountable {
    func calculateDiscountedPrice(for price: Double) -> Double {
        return price * 0.1
    }
}

class laptopDiscount: Discountable {
    func calculateDiscountedPrice(for price: Double) -> Double {
        return price * 0.3
    }
}

class personalComputerDiscount: Discountable {
    func calculateDiscountedPrice(for price: Double) -> Double {
        return price * 0.2
    }
}

class DiscountCalculator {
    private let discountStrategy: Discountable
    
    init(discountStrategy: Discountable) {
        self.discountStrategy = discountStrategy
    }
    
    func calculateDiscount(for price: Double) -> Double {
        return discountStrategy.calculateDiscountedPrice(for: price)
    }
}


