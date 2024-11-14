//
//  OSPViewContoller.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*
✅ ამ მაგალითში, ვიყენებთ პროტოკოლს OSP_CarInfo კლასის გაფართოებისთვის. შეგვიძლია დავამატოთ ახალი მანქანების ტიპები OSP_CarInfo ცვლილების გარეშე. ცხადია ეს მიდგომა მეტად მოქნილი და ეფექტურია, რადგან ახალი მანქანის ტიპის დამატებისას არანაირი პრობლემა არ შეიქმნება. ყველა კლასი მიიღებს CarInfoProtocol პროტოკოლს, ეს კი საშუალებას მოგვცემს დავამატოთ extension-ები კლასის შეცვლის გარეშე.
 */
import UIKit

protocol OSP_CarInfoProtocol {
    func carInfo() -> String
}

class OSP_GasCar: OSP_CarInfoProtocol {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func carInfo() -> String {
        return "This is a Gas Car named \(self.name)"
    }
}

class OSP_ElectricCar: OSP_CarInfoProtocol {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func carInfo() -> String {
        return "This is an Electric Car named \(self.name)"
    }
}

class OSP_CarInfo {
    func printCarInfo(cars: [OSP_CarInfoProtocol]) {
        for car in cars {
            print(car.carInfo())
        }
    }
}

class OSPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cars: [OSP_CarInfoProtocol] = [
            OSP_GasCar(name: "Mustang"),
            OSP_GasCar(name: "Camry"),
            OSP_ElectricCar(name: "Tesla Model 3"),
            OSP_ElectricCar(name: "Nissan Leaf")
        ]
        
        let carInfo = OSP_CarInfo()
        carInfo.printCarInfo(cars: cars)
    }
}
