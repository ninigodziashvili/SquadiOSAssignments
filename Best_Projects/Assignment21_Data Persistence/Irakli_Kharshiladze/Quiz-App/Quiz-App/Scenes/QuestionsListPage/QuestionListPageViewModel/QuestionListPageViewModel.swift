//
//  QuestionListPageViewModel.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

final class QuestionListPageViewModel {
    let getQuestionsService = GetQuestionsService()
    
    private var questions: [Question] = []
    
    init() {
        questions = getQuestionsService.getQuestions() ?? []
    }
    
    func numberOfQuestions() -> Int {
        questions.count
    }
    
    func getQuestion(at index: Int) -> Question {
        questions[index]
    }
}
