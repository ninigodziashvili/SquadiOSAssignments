//
//  QuestionsListPageVC.swift
//  Quiz-App
//
//  Created by irakli kharshiladze on 03.11.24.
//

import UIKit

final class QuestionsListPageVC: UIViewController {
    private let questionListViewModel = QuestionListPageViewModel()
    
    private let pageWrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let pageTitleAndResetButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Quiz", font: UIFont(name: "Sen-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24), textColor: .white, alignment: .left)
        
        return label
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "8E84FF")
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Sen-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
        
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor(hexString: "B8B2FF").cgColor
        
        return button
    }()
    
    private let questionsTableview: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "0a0e29")
        setupUI()
    }
    
    private func setupUI() {
        setupPageWrapperView()
        setupPageTitleAndResetButtonStackView()
        setupPageTitleAndResetButton()
        setupQuestionsTableView()
        
    }
    
    private func setupPageWrapperView() {
        view.addSubview(pageWrapperView)
        
        NSLayoutConstraint.activate([
            pageWrapperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageWrapperView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageWrapperView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 21),
            pageWrapperView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25),
        ])
    }
    
    private func setupPageTitleAndResetButtonStackView() {
        pageWrapperView.addSubview(pageTitleAndResetButtonStackView)
        
        NSLayoutConstraint.activate([
            pageTitleAndResetButtonStackView.leftAnchor.constraint(equalTo: pageWrapperView.leftAnchor),
            pageTitleAndResetButtonStackView.topAnchor.constraint(equalTo: pageWrapperView.topAnchor),
            pageTitleAndResetButtonStackView.rightAnchor.constraint(equalTo: pageWrapperView.rightAnchor),
        ])
    }
    
    private func setupPageTitleAndResetButton() {
        [pageTitle, resetButton].forEach { pageTitleAndResetButtonStackView.addArrangedSubview($0) }
        
        resetButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        resetButton.addAction(UIAction(handler: { [weak self] _ in
            self?.resetAnswers()
        }), for: .touchUpInside)
    }
    
    private func resetAnswers() {
        UserDefaults.standard.set(0, forKey: "correctAnswer")
        UserDefaults.standard.set(0, forKey: "incorrectAnswer")
        UserDefaults.standard.set([], forKey: "savedAnswers")
    }
    
    private func setupQuestionsTableView() {
        pageWrapperView.addSubview(questionsTableview)
        
        NSLayoutConstraint.activate([
            questionsTableview.leftAnchor.constraint(equalTo: pageWrapperView.leftAnchor),
            questionsTableview.rightAnchor.constraint(equalTo: pageWrapperView.rightAnchor),
            questionsTableview.bottomAnchor.constraint(equalTo: pageWrapperView.bottomAnchor),
            questionsTableview.topAnchor.constraint(equalTo: pageTitleAndResetButtonStackView.bottomAnchor, constant: 15)
        ])
        
        questionsTableview.dataSource = self
        questionsTableview.delegate = self
        questionsTableview.register(QuestionsListTableViewCell.self, forCellReuseIdentifier: "QuestionsListTableViewCell")
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

extension QuestionsListPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionListViewModel.numberOfQuestions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsListTableViewCell", for: indexPath) as? QuestionsListTableViewCell else {
            return UITableViewCell()
        }
        
        let currentQuestion = questionListViewModel.getQuestion(at: indexPath.row)
        cell.configureCell(with: currentQuestion.questionNumber)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentQuestion = questionListViewModel.getQuestion(at: indexPath.row)
        
        let vc = QuestionDetailsVC()
        vc.question = currentQuestion
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
