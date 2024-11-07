//
//  Quiz_viewModel.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 02.11.24.
//

import UIKit
import Foundation

final class QuizViewModel {
    private var quizArray = [QuestionModel]()
    let fileManager = FileManager.default
    var documentsDirectoryPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
    
    init() {
        addNewFolder()
        addJsonToFolder()
        
        if let result = loadQuestionsFromDocuments() {
            quizArray = result.results
        }
    }
    
    func addNewFolder() {
        guard let documentsDirectoryPath = documentsDirectoryPath else { return }

        let path = documentsDirectoryPath.appendingPathComponent("Documents")
        
        do {
            try fileManager.createDirectory(
                at: path,
                withIntermediateDirectories: true
            )
        } catch {
            print(error)
        }
    }
    
    func addJsonToFolder() {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    
        let fileURL = documentsDirectory.appendingPathComponent("Questions.json")
        
        if fileManager.fileExists(atPath: fileURL.path) { return }
        
        if let bundlePath = Bundle.main.path(forResource: "Questions", ofType: "json") {
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: fileURL.path)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("no file")
        }
    }

    func loadQuestionsFromDocuments() -> QuizResponse? {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentsDirectory.appendingPathComponent("Questions.json")
        
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            let decoder = JSONDecoder()
            let questions = try decoder.decode(QuizResponse.self, from: data)
            
            return questions
        } catch {
            return nil
        }
    }
    
    var questionsCount: Int {
        quizArray.count
    }
    
    func getSingleQuestion(index: Int) -> QuestionModel {
        quizArray[index]
    }
    
    func resetResults(alert: (String) -> Void) {
        UserDefaults.standard.set(0, forKey: AnswerStatus.answersCorrect.rawValue)
        UserDefaults.standard.set(0, forKey: AnswerStatus.answersIncorrect.rawValue)
        
        for num in 0...questionsCount {
            UserDefaults.standard.removeObject(forKey: "quiz\(num)")
        }
        
        alert("Your result has been cleared.")
    }
}
