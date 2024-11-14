//
//  LSPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*
✅ კარგ შემთხვევაში, ჩვენ კი არ ვცვლით, მშობელი კლასის ქცევას, არამედ შევქმენით პროტოკოლი LSP_Car, რომელსაც აკმაყოფილებს თითოეული კლასი. ეს მიდგომა საშუალებას აძლევს ორივე კლასს LSP_GasCar და LSP_ElectricCar, რომ გამოიყენონ efficiency() მეთოდი თუმცა თავისებურად.
 */
import UIKit

protocol LSP_Car {
    func efficiency() -> Double
}

class LSP_GasCar: LSP_Car {
    let distance: Int
    let fuel: Int
    
    init(distance: Int, fuel: Int) {
        self.distance = distance
        self.fuel = fuel
    }
    
    func efficiency() -> Double {
        return Double(distance) / Double(fuel)
    }
}

class LSP_ElectricCar: LSP_Car {
    let distance: Int
    let batteryUsage: Int
    
    init(distance: Int, batteryUsage: Int) {
        self.distance = distance
        self.batteryUsage = batteryUsage
    }
    
    func efficiency() -> Double {
        return Double(distance) / Double(batteryUsage)
    }
}

class LSPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gasCar: LSP_Car = LSP_GasCar(distance: 500, fuel: 25)
        print("Gas Car Efficiency: ", gasCar.efficiency())
        
        let electricCar: LSP_Car = LSP_ElectricCar(distance: 500, batteryUsage: 50)
        print("Electric Car Efficiency: ", electricCar.efficiency())
    }
}
