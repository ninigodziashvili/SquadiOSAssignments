//
//  NotISPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//
/*
 ❌ ამ შემთხვევაში NotISP_HybridCar და NotISP_ElectricCar იღებენ NotISP_Car პროტოკოლს, თუმცა NotISP_ElectricCar გადატვირთულია არასაჭირო refuel() ფუნქციით, რაც არასწორი მიდგომაა რადგანაც რეალურ პროექტში ეს გაართულებს უზერითვის ინტერფეისის აღქმას. ან კოდირების პროცესში UIkit-ის კლასების შექმნისას უნდა გავითვალისწონოთ განვსაზღვროთ მხოლოდ ის ფუნქციები რომელიც აუცილებელია.
 */

import UIKit

protocol NotISP_Car {
    func startEngine()
    func chargeBattery()
    func refuel()
}

class NotISP_HybridCar: NotISP_Car {
    func startEngine() {
        print("🔋💨 Starting hybrid engine.")
    }
    
    func chargeBattery() {
        print("🔋 Charging hybrid car battery.")
    }
    
    func refuel() {
        print("⛽️ Refueling hybrid car.")
    }
}

class NotISP_ElectricCar: NotISP_Car {
    func startEngine() {
        print("🔋 Starting electric car battery.")
    }
    
    func chargeBattery() {
        print("🔋 Charging electric car battery.")
    }
    
    func refuel() {
        fatalError("❌⛽️ Electric cars do not need refueling!")
    }
}

class NotISPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let hybridCar = NotISP_HybridCar()
        hybridCar.startEngine()
        hybridCar.chargeBattery()
        hybridCar.refuel()
        let electricCar = NotISP_ElectricCar()
        electricCar.startEngine()
    }
}
