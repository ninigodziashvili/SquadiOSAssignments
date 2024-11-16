//
//  DependencyInversion.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*
✅ კარგ შემთხვევაში ჩვენი კლასები უნდა იყვნენ დამოკიდებული აბსტრაქციებზე, ამ მაგალითში შევქმენით DIPCar პროტოკოლი, რომელიც განსაზღვრავს საერთო start() მეთოდს, ხოლო დაბალი დონის Car კლასები იღებენ ამ პროტოკოლს. ეს საშუალებას გვაძლევს დავამატოთ ახალი კლასი, მაგალითად DIPHybridCar და არ დაგვჭირდეს DIPCarHandler მაღალი დონის კლასის ცვლილება, ეს გვინარჩუნებს მოქნილობას
 */

import UIKit

protocol DIPCar {
    func start()
}

class DIPGasCar: DIPCar {
    func start() {
        print("Woom Woomm Wommmm...💨")
    }
}

class DIPElectricCar: DIPCar {
    func start() {
        print("🔋")
    }
}

class DIPHybridCar: DIPCar {
    func start() {
        print("🔋 💨")
    }
}

class DIPCarHandler {
    let car: DIPCar
    
    init(car: DIPCar) {
        self.car = car
    }
    
    func startCar() {
        car.start()
    }
}

class DependencyInversionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gasCar = DIPGasCar()
        let carHandler = DIPCarHandler(car: gasCar)
        carHandler.startCar()
        
        let electricCar = DIPElectricCar()
        let electricCarHandler = DIPCarHandler(car: electricCar)
        electricCarHandler.startCar()
        
        let hybridCar = DIPHybridCar()
        let hybridCarHandler = DIPCarHandler(car: hybridCar)
        hybridCarHandler.startCar()
    }
}




