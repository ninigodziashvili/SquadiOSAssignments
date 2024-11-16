//
//  SRPViewController.swift
//  SOLID
//
//  Created by Nino Kurshavishvili on 13.11.24.
//

/*
✅ ამ მაგალითში SRP პრინციპი დაცვულია, რადგან კლასებს აქვთ გაყოფილი ფუნქციები და ერთი კლასი ერთ ამოცანას ემსახურება. კოდი მეტად მოდულარულია, რაც ამარტივებს მის წაკითხვადობას. დეველოპერისთვის უფრო მარტივია გაიგოს რა დანიშნულება აქვს თითოეულ კლასს. ტესტირება უფრო ადვილი ხდება, რადგან თითოეულ კლასს აქვს ორიენტირებული პასუხისმგებლობა.
 */

import UIKit

class SRP_CarDataFetcher {
    func fetchCarsData() -> [String] {
        return ["Car1", "Car2", "Car3"]
    }
}

class SRP_CarDetailsProcessor {
    func fetchCarDetails(cars: [String]) -> [String: String] {
        return ["Car1": "Details1", "Car2": "Details2", "Car3": "Details3"]
    }
}

class SRP_CarDataSaver {
    func saveCarInfo(carDetails: [String: String]) {
    }
}

class SRP_CarManager {
    private var carDataFetcher: SRP_CarDataFetcher
    private var carDetailsProcessor: SRP_CarDetailsProcessor
    private var carDataSaver: SRP_CarDataSaver
    
    init(carDataFetcher: SRP_CarDataFetcher, carDetailsProcessor: SRP_CarDetailsProcessor, carDataSaver: SRP_CarDataSaver) {
        self.carDataFetcher = carDataFetcher
        self.carDetailsProcessor = carDetailsProcessor
        self.carDataSaver = carDataSaver
    }
    
    func manageCarInfo() {
        let cars = carDataFetcher.fetchCarsData()
        let carDetails = carDetailsProcessor.fetchCarDetails(cars: cars)
        carDataSaver.saveCarInfo(carDetails: carDetails)
    }
}

class SRPViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let carDataFetcher = SRP_CarDataFetcher()
        let carDetailsProcessor = SRP_CarDetailsProcessor()
        let carDataSaver = SRP_CarDataSaver()
        let carManager = SRP_CarManager(carDataFetcher: carDataFetcher, carDetailsProcessor: carDetailsProcessor, carDataSaver: carDataSaver)
        carManager.manageCarInfo()
    }
}
