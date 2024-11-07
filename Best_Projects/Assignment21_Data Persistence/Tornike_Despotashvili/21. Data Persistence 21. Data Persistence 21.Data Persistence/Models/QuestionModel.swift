//
//  QuestionModel.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 03.11.24.
//
import Foundation

struct QuestionModel: Codable {
    let questionNumber: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case questionNumber
        case difficulty
        case category
        case question 
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

struct QuizResponse: Codable {
    let response_code: Int
    let results: [QuestionModel]
}
