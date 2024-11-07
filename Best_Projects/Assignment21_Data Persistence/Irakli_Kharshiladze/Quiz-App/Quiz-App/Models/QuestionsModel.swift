//
//  QuestionsModel.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

struct Question: Decodable {
    let questionNumber: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct QuestionsResponse: Decodable {
    let response_code: Int
    let results: [Question]
}
