//
//  QuestionViewModel.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 02.11.24.
//

import Foundation

enum AnswerStatus: String {
    case answersCorrect = "answersCorrect"
    case answersIncorrect = "answersIncorrect"
}

protocol QuestionViewModelDelegate: AnyObject {
    func didUpdateAnswerCounts(correct: Int, incorrect: Int)
}

final class QuestionViewModel {
    weak var delegate: QuestionViewModelDelegate?
    
    var correctAnswerCount: Int = 0 {
        didSet {
            delegate?.didUpdateAnswerCounts(correct: correctAnswerCount, incorrect: incorrectAnswerCount)
            UserDefaults.standard.set(correctAnswerCount, forKey: AnswerStatus.answersCorrect.rawValue)
        }
    }
    
    var incorrectAnswerCount: Int = 0 {
        didSet {
            delegate?.didUpdateAnswerCounts(correct: correctAnswerCount, incorrect: incorrectAnswerCount)
            UserDefaults.standard.set(incorrectAnswerCount, forKey: AnswerStatus.answersIncorrect.rawValue)
        }
    }
    
    init() {
        self.correctAnswerCount = UserDefaults.standard.integer(forKey: AnswerStatus.answersCorrect.rawValue)
        self.incorrectAnswerCount = UserDefaults.standard.integer(forKey: AnswerStatus.answersIncorrect.rawValue)
    }
    
    func incremetnCorrects() {
        correctAnswerCount += 1
    }
    
    func incrementIncorrectAnswers() {
        incorrectAnswerCount += 1
    }
    
    func saveDataInStorage(currentQuiz: QuestionModel, myAnswer: String) {
        let saveStatus = SingleQuizStatus(isAnswered: true, prevAnswer: myAnswer)
        
        if let encodedData = try? JSONEncoder().encode(saveStatus) {
            UserDefaults.standard.set(encodedData, forKey: "quiz\(currentQuiz.questionNumber)")
        }
    }
    
    func getDataFromStorage(currentQuiz: QuestionModel) -> SingleQuizStatus? {
        let retirevedData = UserDefaults.standard.data(forKey: "quiz\(currentQuiz.questionNumber)")
        let decodedData = try? JSONDecoder().decode(SingleQuizStatus.self, from: retirevedData ?? Data())
        return decodedData
    }
}
