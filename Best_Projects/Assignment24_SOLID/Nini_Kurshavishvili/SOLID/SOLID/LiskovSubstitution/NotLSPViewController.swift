//
//  NotLSPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//
/*
 ❌ LS პრინციპის მიხედვით როდესაც გვაქვს მშობელი და შვილობილი კლასი, შვილობილ კლასმა არ უნდა შეცვალოს მშობლის ფუნქციის ლოგიკა. ამ შემთხვევაში, ვინაიდან NotLSP_ElectricCar კლასს არ აქვს საწვავი, ის ცვლის მშობელი NotLSP_Car კლასის ფუნქციონალს და თავისებურად იყენებს, რაც არღვევს LSP-ს.
 */
import UIKit

class NotLSP_Car {
    func fuelEfficiency(distance: Int, fuel: Int) -> Double {
        return Double(distance) / Double(fuel)
    }
}

class NotLSP_ElectricCar: NotLSP_Car {
    override func fuelEfficiency(distance: Int, fuel: Int) -> Double {
        return Double(distance) / 0.0
    }
}

class NotLSPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let car = NotLSP_Car()
        print("Fuel efficiency of Car:", car.fuelEfficiency(distance: 500, fuel: 25))
        
        let electricCar = NotLSP_ElectricCar()
        print("Fuel efficiency of ElectricCar:", electricCar.fuelEfficiency(distance: 500, fuel: 0))
    }
}
