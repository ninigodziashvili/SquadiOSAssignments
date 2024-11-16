//
//  NotFollowingDependencyInversionPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
//
/*
 -- DependencyInversion პრინციპის თანახმად მაღალი დონის მოდულები არ უნდა იყვნენ დამოკიდებული
 დაბალი დონის მოდულებზე.
 
 -- ჩვენს შემთხვევაში data setvice manager კლასი დამოკიდებულია არა აბსტრაქციასა ან ინტერფეისზე, არამედ იმპლემენტაზიაზე.
 
 -- ეს ზღუდავს მის მოქნილობას და ნებისმიერი ცვლილება DataSverService-ში გამოიწვევს ცვლილების
 საჭიროებას მენეჯეშიც, რაც ართულებს maintanance-ს
 */

final class DataSaverService {
    func saveDataWithUserDefaults() {
        print("data saved using user defaults")
    }
    
    func saveDataWithFileManager() {
        print("data saved using file manager")
    }
}

final class DataSaverManager {
    let dataSaverService = DataSaverService()
    
    func saveData() {
        dataSaverService.saveDataWithFileManager()
        dataSaverService.saveDataWithUserDefaults()
    }
}
