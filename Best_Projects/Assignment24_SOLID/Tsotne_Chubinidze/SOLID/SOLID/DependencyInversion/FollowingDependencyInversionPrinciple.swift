//
//  FollowingDependencyInversionPrinciple.swift
//  SOLID
//
//  Created by Cotne Chubinidze on 13.11.24.
// minor change for git
/*
 -- სწორ შემთხვევაში DataSaveManager - კლასი ემუშავება DataSavable ტიპის ობიექტებს და
 არა კონკრეტულ ინსტანსებს, რაც გვიმარტივებს ფუნქციონალის დამატებას და DataSaveManager-ს
 ათავისუფლებს კონკრეტულ ინსტანსზე დამოკიდებულებისგან.
 
 -- UserDefaultsDataService & FileManagerDataService არიან დაბალი დონის კლასები
 რომლებიც ექვემდებარებიან კონკრეტულ პროტოკოლს. ეს გვაძლევს საშუალებას შევქმნათ მათი მსგავსი კლასები
 განუსაზღვრელი რაოდენობით, ისე რომ კოდის სხვა ნაწილში ცვლილება არ გახდება საჭირო.
 */
protocol DataSavable {
    func saveData()
}

final class UserDefaultsDataService: DataSavable {
    func saveData() {
        print("save data using user defaults")
    }
}

final class FileManagerDataService: DataSavable {
    func saveData() {
        print("save data using file manager")
    }
}

final class DataSaveManager {
    let dataSvingService: DataSavable
    
    init(dataSvingService: DataSavable) {
        self.dataSvingService = dataSvingService
    }
    
    func saveData() {
        dataSvingService.saveData()
    }
}
