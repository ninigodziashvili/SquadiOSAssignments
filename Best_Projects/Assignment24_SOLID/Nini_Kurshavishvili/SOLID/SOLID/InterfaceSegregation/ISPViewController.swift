//
//  ISPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//
/*
✅ კარგ შემთხვევაში, ყველა ტიპის მანქანისთვის შევქმენით ცალკეული პროტოკოლები და თავიდან ავიცილეთ არასაჭირო ფუნქციების გადატვირთვა, ასევე დაცვულია ISP. მაგალითად HybridCar დააკმაყოფილებს ყველა პროტოკოლს, რადგან ძრავიც აქვს, ბაკიც, და ელემენტებიც. ElectricCar კლასი ცხადია მხოლოდ chargeBattery() პროტოკოლს დააკმაყოფილებს და არ მოგვიწევს არასაჭირო ფუნქცია მივაწოდოთ. შევინარჩუნეთ სიმარტივე და მეტად ორგანიზებული და მართვადია ჩვენი კოდი.
 */
import UIKit

protocol ISP_EngineStartable {
    func startEngine()
}

protocol ISP_BatteryChargeable {
    func chargeBattery()
}

protocol ISP_Refuelable {
    func refuel()
}

class ISP_HybridCar: ISP_EngineStartable, ISP_BatteryChargeable, ISP_Refuelable {
    func startEngine() {
        print("🔋💨... Starting hybrid engine.")
    }
    
    func chargeBattery() {
        print("🔋 Charging hybrid battery.")
    }
    
    func refuel() {
        print("⛽️ Refueling hybrid car.")
    }
}

class ISP_ElectricCar: ISP_BatteryChargeable {
    
    func chargeBattery() {
        print("🔋 Charging electric car battery.")
    }
}

class ISP_GasCar: ISP_EngineStartable, ISP_Refuelable {
    func startEngine() {
        print("💨Starting gas engine.")
    }
    
    func refuel() {
        print("⛽️ Refueling gas car.")
    }
}

class ISPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hybridCar = ISP_HybridCar()
        hybridCar.startEngine()
        hybridCar.chargeBattery()
        hybridCar.refuel()
        
        let electricCar = ISP_ElectricCar()
        electricCar.chargeBattery()
        
        let gasCar = ISP_GasCar()
        gasCar.startEngine()
        gasCar.refuel()
    }
}

