//
//  NotOSPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*
 ❌ ამ მაგალითში NotOSP_CarInfo კლასს არ აქვს extension, ანუ ახალი მანქანების ტიპების დასამატებლად, ჩვენ პირდაპირ უნდა შევცვალოთ NotOSP_CarInfo, რაც არღვევს OSP პრინციპს.
 */
import UIKit

class NotOSP_GasCar {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func carInfo() -> String {
        return "This is a Gas Car named \(self.name)"
    }
}

class NotOSP_ElectricCar {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func carInfo() -> String {
        return "This is an Electric Car named \(self.name)"
    }
}

class NotOSP_CarInfo {
    func printCarInfo() {
        let gasCars = [NotOSP_GasCar(name: "Mustang"), NotOSP_GasCar(name: "Camry")]
        for car in gasCars {
            print(car.carInfo())
        }
        
        let electricCars = [NotOSP_ElectricCar(name: "Tesla Model 3"), NotOSP_ElectricCar(name: "Nissan Leaf")]
        for car in electricCars {
            print(car.carInfo())
        }
    }
}

class NotOSPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let carInfo = NotOSP_CarInfo()
        carInfo.printCarInfo()
    }
}
