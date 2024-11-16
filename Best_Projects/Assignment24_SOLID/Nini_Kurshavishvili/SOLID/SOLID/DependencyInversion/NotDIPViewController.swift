//
//  NotDIPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*
 ❌ ამ შემთხვევაში, სადაც კლასი NonDIPCarHandler high-level კლასი, პირდაპირ დამოკიდებულებაშია NonDIPElectricCar და NonDIPGasCar low-level კლასებზე - არასწორია, რადგან ჩვენ რომ დაგვჭირდეს ახალი კლასის დამატება, მოგვიწევს high-level კლასის, NonDIPCarHandler-ის ცვლილება, რაც გვიკარგავს მოქნილობას და გვირთულებს კოდზე კონტროლს.
 */

import UIKit

class NonDIPGasCar {
    func start() {
        print("WOOM WOOMMM WOOMMM 💨")
    }
}

class NonDIPElectricCar {
    func start() {
        print("🔋...")
    }
}

class NonDIPCarHandler {
    let gasCar: NonDIPGasCar
    let electricCar: NonDIPElectricCar
    
    init(gasCar: NonDIPGasCar, electricCar: NonDIPElectricCar) {
        self.gasCar = gasCar
        self.electricCar = electricCar
    }
    
    func startGasCar() {
        gasCar.start()
    }
    
    func startElectricCar() {
        electricCar.start()
    }
}

class NotDIPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gasCar = NonDIPGasCar()
        let electricCar = NonDIPElectricCar()
        let carHandler = NonDIPCarHandler(gasCar: gasCar, electricCar: electricCar)
        
        carHandler.startGasCar()
        carHandler.startElectricCar()
    }
}

