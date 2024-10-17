//
//  HistoryVC.swift
//  Assignement13
//
//  Created by Sandro Tsitskishvili on 16.10.24.
//

import UIKit

class HistoryVC: UIViewController {
    
    weak var delegate: HistoryDelegate?
    var history: [String] = []
    var isDarkMode: Bool = false
    
    private func updateUI() {
        view.backgroundColor = isDarkMode ? .black : .systemBackground
        historyStackView.backgroundColor = isDarkMode ? .clear : .white
        
        for case let label as UILabel in historyStackView.arrangedSubviews {
            label.textColor = isDarkMode ? .white : .black
        }
        if let backButton = navigationItem.leftBarButtonItem {
            backButton.tintColor = isDarkMode ? .white : .black
        }
    }
    
    private let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        customizeBackButton()
        setupHistoryStackView()
        displayHistory()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func customizeBackButton () {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward.circle"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = isDarkMode ? .white : .black
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupHistoryStackView() {
        view.addSubview(historyStackView)
        
        NSLayoutConstraint.activate([
            historyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            historyStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            historyStackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func displayHistory() {
        historyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for calculation in history.reversed() {
            let historyLabel = UILabel()
            historyLabel.text = calculation
            historyLabel.textColor = isDarkMode ? .white : .black
            historyLabel.textAlignment = .right
            historyStackView.addArrangedSubview(historyLabel)
        }
    }
}




