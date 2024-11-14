//
//  FollowingOpenClosedPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
class OuterClassForCapsulation2 {
    /*
     -- Open–closed principle-ის გათვალისწინებით შმეოგვავქვს პროტოკოლი რომელსაც მივაღებინებთ ახალი ტრანსპორტის კლასს და ეს ჩვენი TransportInfo- კლასი პირდაპირ მოერგება მას, რადგან ის მუშაობს პროტოკოლის მიმღებ ნებისმიერ ინსტანსთან და არა რაიმე კონკრეტულ კლასებთან.
     */
    protocol Printable {
        func printInfo()
    }
    
    final class TransportInfo {
        private let transport: Printable
        
        init(transport: Printable) {
            self.transport = transport
        }
        
        func printTransportInfo() {
            transport.printInfo()
        }
    }
    
    final class Car: Printable {
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
        
        func printInfo() {
            print("""
        Car brand: \(self.barand)
        Fuel Consumption Per Hundread Km: \(self.fuelConsumptionPerHundreadKm)
        Fuel Tank Size In Litres: \(self.fuelTankSizeInLitres)
        HasAirbag: \(self.hasAirbag)
        """)
        }
    }
    
    final class Bike: Printable {
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
        
        func printInfo() {
            print("""
        Bike brand: \(self.barand)
        Fuel Consumption Per Hundread Km: \(self.fuelConsumptionPerHundreadKm)
        Fuel Tank Size In Litres: \(self.fuelTankSizeInLitres)
        HasAirbag: \(self.hasAirbag)
        """)
        }
    }
    
    final class Boat: Printable {
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
        
        func printInfo() {
            print("""
        Boat brand: \(self.barand)
        Fuel Consumption Per Hundread Km: \(self.fuelConsumptionPerHundreadKm)
        Fuel Tank Size In Litres: \(self.fuelTankSizeInLitres)
        HasAirbag: \(self.hasAirbag)
        """)
        }
    }
    
    final class Helicopter: Printable {
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
        
        func printInfo() {
            print("""
        Helicopter brand: \(self.barand)
        Fuel Consumption Per Hundread Km: \(self.fuelConsumptionPerHundreadKm)
        Fuel Tank Size In Litres: \(self.fuelTankSizeInLitres)
        HasAirbag: \(self.hasAirbag)
        """)
        }
    }
}
