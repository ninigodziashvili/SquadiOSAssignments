//
//  NoDependencyInversion.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 14.11.24.
//

import Foundation

class NoDependencyInversion {
    
    /*
     ViewController მჭიდროდ  კავშირშია NetworkManager-თან,
     რაც ართულებს NetworkManager-ის ცვლილებას სხვა ნეთვორქინგ კლასით.
     ამასთან არ არსებობს აბსტრაქცია, პრობლემურს ხდის ტესტირების პროცესს
     */

    // დაბალი დონის მოდული
    class EmailSender {
        func send(message: String) {
            print("Email sent: \(message)")
        }
    }
    
    // მაღალი დონის მოდული
    
    class NotificationService {
        
        // პირდაპირი დამოკიდებულება
        
        private let emailSender = EmailSender()
        
        func notify(message: String) {
            emailSender.send(message: message)
        }
    }
    
    let notificationService = NotificationService()
    
    func notifyMe() {
        notificationService.notify(message: "Good Night Lady")
    }
}
