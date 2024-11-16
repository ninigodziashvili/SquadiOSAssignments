//
//  DependencyInversion.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 14.11.24.
//

import Foundation

class DependencyInversion {
    /*
     მაღალი დონის მოდულები არ უნდა იყოს დამოკიდებული დაბალი დონის მოდულებზე,
     არამედ ორივე უნდა იყოს დამოკიდებული აბსტრაქციებზე.
     ეს შესაძლებელს ხდის მივიღოთ მეტი მოქნილობა და ტესტირება თქვენს კოდში.
     NotificationService დამოკიდებულია MessageSender პროტოკოლზე,
     რაც მოქნილს ხდის სხვადასხვა შეტყობინეფის ფუნქციონალთან მუშაობას.
     */
    
    protocol MessageSender {
        func send(message: String)
    }
    
    class EmailSender: MessageSender {
        func send(message: String) {
            print("Email sent: \(message)")
        }
    }
    
    class SMSSender: MessageSender {
        func send(message: String) {
            print("SMS sent: \(message)")
        }
    }
    
    class NotificationService {
        private let sender: MessageSender
        
        init(sender: MessageSender) {
            self.sender = sender
        }
        
        func notify(message: String) {
            sender.send(message: message)
        }
    }
    
    let emailSender = EmailSender()
    let smsSender = SMSSender()
    func sendNotification() {
        let emailNotificationService = NotificationService(sender: emailSender)
        let smsNotificationService = NotificationService(sender: smsSender)
        
        emailNotificationService.notify(message: "Say Hello to my little friend")
        smsNotificationService.notify(message: "Welcome Sarah")
    }
}
