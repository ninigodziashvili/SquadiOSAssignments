//
//  QuestionDetailsVC.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

import UIKit

final class QuestionDetailsVC: UIViewController {
    var question: Question?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let navigationButtonAndQuestionNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let navigationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private let questionNumberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = UIColor(hexString: "8E84FF")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(hexString: "B8B2FF").cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Question", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), textColor: .white, alignment: .center)

        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Sen-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20), textColor: .white, alignment: .left, numberOfLines: 0)
        
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let answerButtonOne: UIButton = {
        let button = UIButton()
        button.configureButton(text: "", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), titleColor: UIColor(hexString: "2B0063"), tintColor: UIColor(hexString: "2B0063"), image: "circle", backgroundColor: .white)
        
        return button
    }()
    
    private let answerButtonTwo: UIButton = {
        let button = UIButton()
        button.configureButton(text: "", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), titleColor: UIColor(hexString: "2B0063"), tintColor: UIColor(hexString: "2B0063"), image: "circle", backgroundColor: .white)
        
        return button
    }()
    
    private let answerButtonThree: UIButton = {
        let button = UIButton()
        button.configureButton(text: "", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), titleColor: UIColor(hexString: "2B0063"), tintColor: UIColor(hexString: "2B0063"), image: "circle", backgroundColor: .white)
        
        return button
    }()
    
    private let answerButtonFour: UIButton = {
        let button = UIButton()
        button.configureButton(text: "", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), titleColor: UIColor(hexString: "2B0063"), tintColor: UIColor(hexString: "2B0063"), image: "circle", backgroundColor: .white)
        
        return button
    }()
    
    private let resultsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "8E84FF")
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let resultsLabel: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Correct Answer", font: UIFont(name: "Sen-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16), textColor: .white, alignment: .left)
        label.clipsToBounds = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "0a0e29")
        setupUI()
        checkSavedQuestions()
    }
    
    private func setupUI() {
        setupScrollView()
        setupNavigationButtonAndQuestionNumberStackView()
        setupNavigationButtonAndQuestionNumberLabel()
        setupQuestion()
        setupButtonsStackView()
        setupAnswerButtons()
        setupResults()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
    
    private func setupNavigationButtonAndQuestionNumberStackView() {
        contentView.addSubview(navigationButtonAndQuestionNumberStackView)
        
        NSLayoutConstraint.activate([
            navigationButtonAndQuestionNumberStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            navigationButtonAndQuestionNumberStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            navigationButtonAndQuestionNumberStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    private func setupNavigationButtonAndQuestionNumberLabel() {
        [navigationButton, questionNumberView].forEach { navigationButtonAndQuestionNumberStackView.addArrangedSubview($0) }
        
        questionNumberView.addSubview(questionNumberLabel)
        
        NSLayoutConstraint.activate([
            questionNumberView.heightAnchor.constraint(equalToConstant: 45),
            questionNumberView.widthAnchor.constraint(equalToConstant: 100),
            
            questionNumberLabel.centerXAnchor.constraint(equalTo: questionNumberView.centerXAnchor),
            questionNumberLabel.centerYAnchor.constraint(equalTo: questionNumberView.centerYAnchor)
        ])
        
        questionNumberLabel.text = "Question \(question?.questionNumber ?? "")"
        navigationButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupQuestion() {
        contentView.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            questionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            questionLabel.topAnchor.constraint(equalTo: navigationButtonAndQuestionNumberStackView.bottomAnchor, constant: 25)
        ])
        
        questionLabel.text = question?.question
    }
    
    private func setupButtonsStackView() {
        contentView.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            buttonsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            buttonsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 25),
        ])
    }
    
    private func setupAnswerButtons() {
        [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour].forEach { button in
            buttonsStackView.addArrangedSubview(button)
            button.addAction(UIAction(handler: { [weak self] _ in
                self?.checkAnswer(button)
            }), for: .touchUpInside)
        }
        
        var answers: [String] = question?.incorrect_answers ?? [""]
        answers.append(question?.correct_answer ?? "")
        answers.shuffle()
        
        for (index, button) in [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour].enumerated() {
            if index < answers.count{
                button.setTitle(answers[index], for: .normal)
            }
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
    }
    
    private func updateButtons(selectedAnswer: String, isCorrect: Bool) {
        let buttons: [UIButton] = [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour]
        
        for button in buttons {
            if button.title(for: .normal) == selectedAnswer {
                button.backgroundColor = UIColor(hexString: "8E84FF")
                button.setTitleColor(.white, for: .normal)
                button.setImage(UIImage(systemName: isCorrect ? "checkmark.circle.fill" : "checkmark.circle"), for: .normal)
            }
        }
    }
    
    private func checkSavedQuestions() {
        guard let savedAnswers = UserDefaults.standard.array(forKey: "savedAnswers") as? [[String: String]] else { return }
        
        for answer in savedAnswers {
            guard let questionText = question?.question,
                  let selectedAnswer = answer["selectedAnswer"],
                  let correctAnswer = question?.correct_answer else { return }
            
            if questionText == answer["question"] {
                if selectedAnswer == correctAnswer {
                    updateButtons(selectedAnswer: selectedAnswer, isCorrect: true)
                } else {
                    updateButtons(selectedAnswer: selectedAnswer, isCorrect: false)
                }
                
                [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour].forEach { $0.isEnabled = false }
            }
        }
    }
    
    private func checkAnswer(_ sender: UIButton) {
        guard let selectedAnswer = sender.title(for: .normal),
              let correctAnswer = question?.correct_answer,
              let question = question?.question else { return }
        
        if selectedAnswer == correctAnswer {
            var correctAnswer = UserDefaults.standard.integer(forKey: "correctAnswer")
            correctAnswer += 1
            UserDefaults.standard.set(correctAnswer, forKey: "correctAnswer")
            
            sender.backgroundColor = UIColor(hexString: "8E84FF")
            sender.setTitleColor(.white, for: .normal)
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
        } else {
            var incorrectAnswer = UserDefaults.standard.integer(forKey: "incorrectAnswer")
            incorrectAnswer += 1
            UserDefaults.standard.set(incorrectAnswer, forKey: "incorrectAnswer")
            
            sender.backgroundColor = UIColor(hexString: "8E84FF")
            sender.setTitleColor(.white, for: .normal)
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        
        var savedQuestions = UserDefaults.standard.array(forKey: "savedAnswers") as? [[String: String]] ?? []
        let questionData = [
            "question": question,
            "selectedAnswer": selectedAnswer,
            "correctAnswer": correctAnswer
        ]
        
        savedQuestions.append(questionData)
        UserDefaults.standard.set(savedQuestions, forKey: "savedAnswers")
        
        [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour].forEach { $0.isEnabled = false }
        
        updateResultsLabel()
    }
    
    private func setupResults() {
        contentView.addSubview(resultsView)
        
        NSLayoutConstraint.activate([
            resultsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            resultsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            resultsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150),
            resultsView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        resultsView.addSubview(resultsLabel)
        
        NSLayoutConstraint.activate([
            resultsLabel.centerYAnchor.constraint(equalTo: resultsView.centerYAnchor),
            resultsLabel.leftAnchor.constraint(equalTo: resultsView.leftAnchor, constant: 15),
            resultsLabel.rightAnchor.constraint(equalTo: resultsView.rightAnchor, constant: -15)
        ])
        
        let correctAnswer = UserDefaults.standard.integer(forKey: "correctAnswer")
        let incorrectAnswer = UserDefaults.standard.integer(forKey: "incorrectAnswer")
        
        resultsLabel.text = "Correct Answer \(correctAnswer) / Incorrect \(incorrectAnswer)"
    }
    
    private func updateResultsLabel() {
        let correctAnswer = UserDefaults.standard.integer(forKey: "correctAnswer")
        let incorrectAnswer = UserDefaults.standard.integer(forKey: "incorrectAnswer")
        
        resultsLabel.text = "Correct Answer \(correctAnswer) / Incorrect \(incorrectAnswer)"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
