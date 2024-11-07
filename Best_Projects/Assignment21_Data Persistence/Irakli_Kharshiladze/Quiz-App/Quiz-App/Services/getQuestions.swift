//
//  getQuestions.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

import Foundation
final class GetQuestionsService {
    
    func getQuestions() -> [Question]? {
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json") else {
            print("Cant find json file.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(QuestionsResponse.self, from: data)
            return response.results
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
