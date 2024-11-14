//
//  Incorrect.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ამ მაგალითში დავამატე GiftCardPayment რომელიც არ გვაძლევს შესაძლებლობას გავაკეთოთ ნაწილობრივი გადახდა, თუმცა ის მემკვიდრეობით იღებს  processPayment მეთოდს და override-ით აგდებს ერორრს როდესაც Gift card-ით ცდილობენ ნაწილობრივ გადახდას, ეს არღვევს LSP პრინციპს, რადგან GiftCardPayment-ს არ შეუძლია მშობელი კლასის ჩანაცვლება უპრობლემოდ */

class PaymentProcessor {
    func processPayment(amount: Double) {
    }
}

class CreditCardPayment: PaymentProcessor {
    override func processPayment(amount: Double) {
    }
}

class PayPalPayment: PaymentProcessor {
    override func processPayment(amount: Double) {
    }
}

class GiftCardPayment: PaymentProcessor {
    override func processPayment(amount: Double) {
        if amount <= 0 {
            fatalError("You can not pay partially with Gift Card")
        }
        print("Processing")
    }
}


