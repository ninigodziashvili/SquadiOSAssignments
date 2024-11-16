//
//  Correct.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ამ მაგალითით ჩვენ უკვე ვიცავთ LSP პრინციპს, შემქნილია ცალკე პროტოკოლი მთლიანი გადახდისთვის, ამ შემთხვევაში  GiftCardPayment მემკვიდრეობით აღარ იღებს ისეთ მეთოდს რისი შესრულებაც არ შეუძლია და ალტერნატიულად აქვს processFullPayment. */

protocol PaymentProcessor {
    func processPayment(amount: Double)
}

protocol FullPaymentProcessor: PaymentProcessor {
    func processFullPayment(amount: Double)
}

class CreditCardPayment: PaymentProcessor {
    func processPayment(amount: Double) {
    }
}

class PayPalPayment: PaymentProcessor {
    func processPayment(amount: Double) {
    }
}

class GiftCardPayment: FullPaymentProcessor {
    func processPayment(amount: Double) {
        fatalError("You can not pay partially with Gift Card")
    }
    
    func processFullPayment(amount: Double) {
        print("Processing full gift card payment")
    }
}

