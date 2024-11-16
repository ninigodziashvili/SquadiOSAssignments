//
//  Correct.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ამ შემთხვევაში  Order კლასი დავყავით 3 ცალკეულ კლასად (OrderValidator,EmailService,OrderProcessor) რომლებსაც აქვთ თითო პასუხისმგებლობა, ამგვარად თითოეული კლასის ცვლილება არ იმოქმედებს მეორეზე   */

class Order {
    var orderID: String
    var items: [String]

    init(orderID: String, items: [String]) {
        self.orderID = orderID
        self.items = items
    }
}

class OrderValidator {
    func validate(order: Order) -> Bool {
        return !order.items.isEmpty
    }
}

class EmailService {
    func sendConfirmationEmail(to email: String) {
        print("Sending confirmation email to \(email)")
    }
}

class OrderProcessor {
    private let validator: OrderValidator
    private let emailService: EmailService
    private let customerEmail: String

    init(validator: OrderValidator, emailService: EmailService, customerEmail: String) {
        self.validator = validator
        self.emailService = emailService
        self.customerEmail = customerEmail
    }

    func process(order: Order) {
        if validator.validate(order: order) {
            print("Processing order")
            emailService.sendConfirmationEmail(to: customerEmail)
        } else {
            print("Order validation failed ")
        }
    }
}


