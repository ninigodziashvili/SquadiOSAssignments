//
//  Incorrect.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ამ მაგალითში გვაქვს  Order კლასი რომელიც პასუხისმგებელია რამოდენიმე ოპერაციაზე პროცესინგი, ვალიდაცია და შეტყობინების გაგზავნა, ეს Order კლასს ხდის გასატესტად და შესანარჩუნებლად რთულს რადგან ერთერთი ფუნქციის ცვლილებამ შესაძლოა მეორეზეც იმოქმდეოს */

class Order {
    var orderID: String
    var customerEmail: String
    var items: [String]

    init(orderID: String, customerEmail: String, items: [String]) {
        self.orderID = orderID
        self.customerEmail = customerEmail
        self.items = items
    }

    func processOrder() {
        if validateOrder() {
            print("Processing order")
            sendConfirmationEmail()
        } else {
            print("Order validation failed")
        }
    }

    private func validateOrder() -> Bool {
        return !items.isEmpty
    }

    private func sendConfirmationEmail() {
        print("Sending confirmation email to \(customerEmail)")
    }
}


