//
//  NotSRPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*❌კლასი არღვევს SRP-ს. ამ შემთხვევაში ახორციელებს მრავალ ფუნქციას, როგორიცაა მანქანის მონაცემების მართვა, მანქანის დეტალების მოძიება და მანქანის ინფორმაციის შენახვა, რომლებიც ცალკე კლასებმა უნდა მოაგვარონ.*/

import UIKit

class NotSRP_CarManager {
    func manageCarInfo() {
        let cars = getCarsData()
        let carDetails = fetchCarDetails(cars: cars)
        saveCarInfo(carDetails: carDetails)
    }
    
    func getCarsData() -> [String] {
        return ["Car1", "Car2", "Car3"]
    }
    
    func fetchCarDetails(cars: [String]) -> [String: String] {
        return ["Car1": "Details1", "Car2": "Details2", "Car3": "Details3"]
    }
    
    func saveCarInfo(carDetails: [String: String]) {
    }
}

class NotSRPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let carManager = NotSRP_CarManager()
        carManager.manageCarInfo()
    }
}
