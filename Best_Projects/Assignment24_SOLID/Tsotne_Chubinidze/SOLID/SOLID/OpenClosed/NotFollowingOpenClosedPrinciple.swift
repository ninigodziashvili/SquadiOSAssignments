//
//  NotFollowingOpenClosedPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
class OtuterClassForCapsulation1 {
    /*
     -- Open–closed principle-ის თანახმად კლასი უნდა იყოს გაფართოებადი მაგრამ არა შეცვლადი.
     ეს ნიშნავს რომ უნდა შეგვეძლოს დამატებითი ფუნქციონალის შმეოტანა და ეს არ უნდა საჭიროებდეს არსებული კლასის შეცვლას.
     
     -- ჩვენს მაგალითში ახალი ტრანსპორტის დამატება გამოიწვევს printInfoForTransport მეთოდის შეცვლის საჭიროებას, რაც ეწინააღმდეგება პრინციპს
     */
    final class TransportInfo {
        private func printInfoForTransport(for transport: Any) {
            if let car = transport as? Car {
                print("""
                Car brand: \(car.barand)
                Fuel Consumption Per Hundread Km: \(car.fuelConsumptionPerHundreadKm)
                Fuel Tank Size In Litres: \(car.fuelTankSizeInLitres)
                HasAirbag: \(car.hasAirbag)
            """)
            } else if let bike = transport as? Bike {
                print("""
                Bike brand: \(bike.barand)
                Fuel Consumption Per Hundread Km: \(bike.fuelConsumptionPerHundreadKm)
                Fuel Tank Size In Litres: \(bike.fuelTankSizeInLitres)
                HasAirbag: \(bike.hasAirbag)
            """)
            } else if let boat = transport as? Boat {
                print("""
                Boat brand: \(boat.barand)
                Fuel Consumption Per Hundread Km: \(boat.fuelConsumptionPerHundreadKm)
                Fuel Tank Size In Litres: \(boat.fuelTankSizeInLitres)
                HasAirbag: \(boat.hasAirbag)
            """)
            } else if let helicopter = transport as? Helicopter {
                print("""
                Helicopter brand: \(helicopter.barand)
                Fuel Consumption Per Hundread Km: \(helicopter.fuelConsumptionPerHundreadKm)
                Fuel Tank Size In Litres: \(helicopter.fuelTankSizeInLitres)
                HasAirbag: \(helicopter.hasAirbag)
            """)
            }
        }
    }
    
    final class Car {
        let barand: String
        let fuelConsumptionPerHundreadKm: Double
        let fuelTankSizeInLitres: Double
        let hasAirbag: Bool
        
        init(barand: String, fuelConsumptionPerHundreadKm: Double, fuelTankSizeInLitres: Double, hasAirbag: Bool) {
            self.barand = barand
            self.fuelConsumptionPerHundreadKm = fuelConsumptionPerHundreadKm
            self.fuelTankSizeInLitres = fuelTankSizeInLitres
            self.hasAirbag = hasAirbag
        }
    }
    
    final class Bike {
        let barand: String
        let fuelConsumptionPerHundreadKm: Double
        let fuelTankSizeInLitres: Double
        let hasAirbag: Bool
        
        init(barand: String, fuelConsumptionPerHundreadKm: Double, fuelTankSizeInLitres: Double, hasAirbag: Bool) {
            self.barand = barand
            self.fuelConsumptionPerHundreadKm = fuelConsumptionPerHundreadKm
            self.fuelTankSizeInLitres = fuelTankSizeInLitres
            self.hasAirbag = hasAirbag
        }
    }
    
    final class Boat {
        let barand: String
        let fuelConsumptionPerHundreadKm: Double
        let fuelTankSizeInLitres: Double
        let hasAirbag: Bool
        
        init(barand: String, fuelConsumptionPerHundreadKm: Double, fuelTankSizeInLitres: Double, hasAirbag: Bool) {
            self.barand = barand
            self.fuelConsumptionPerHundreadKm = fuelConsumptionPerHundreadKm
            self.fuelTankSizeInLitres = fuelTankSizeInLitres
            self.hasAirbag = hasAirbag
        }
    }
    
    final class Helicopter {
        let barand: String
        let fuelConsumptionPerHundreadKm: Double
        let fuelTankSizeInLitres: Double
        let hasAirbag: Bool
        
        init(barand: String, fuelConsumptionPerHundreadKm: Double, fuelTankSizeInLitres: Double, hasAirbag: Bool) {
            self.barand = barand
            self.fuelConsumptionPerHundreadKm = fuelConsumptionPerHundreadKm
            self.fuelTankSizeInLitres = fuelTankSizeInLitres
            self.hasAirbag = hasAirbag
        }
    }
}
