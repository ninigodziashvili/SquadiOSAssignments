//
//  CalculatorHistoryVC.swift
//  TBC-Assignment-14
//
//  Created by irakli kharshiladze on 16.10.24.
//

import UIKit

class CalculatorHistoryVC: UIViewController {
    var isDark: Bool = false
    var calculatorHistory: [String] = []
    
    private let navigateToCalculaotPageButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        button.setImage(UIImage(systemName: "arrow.left.circle", withConfiguration: config), for: .normal)
        
        return button
    }()
    
    private let historyStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let historyTextView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false

        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = isDark ? .dark : .light
        view.backgroundColor = isDark ? .systemFill : .white
        setupUI()
    }
    

    private func setupUI() {
        setupNavigateToCalculatorPageButton()
        setupHistoryStackView()
    }
    
    private func setupNavigateToCalculatorPageButton() {
        view.addSubview(navigateToCalculaotPageButton)
        
        NSLayoutConstraint.activate([
            navigateToCalculaotPageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 47),
            navigateToCalculaotPageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            navigateToCalculaotPageButton.heightAnchor.constraint(equalTo: navigateToCalculaotPageButton.widthAnchor),
            navigateToCalculaotPageButton.widthAnchor.constraint(equalToConstant: 28)
        ])
        
        navigateToCalculaotPageButton.tintColor = isDark ? .white : .black
        
        navigateToCalculaotPageButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigateToCalculatorPage()
        }), for: .touchUpInside)
    }
    
    private func navigateToCalculatorPage() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupHistoryStackView() {
        view.addSubview(historyStackView)
        
        NSLayoutConstraint.activate([
            historyStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            historyStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
        
        calculatorHistory.forEach {
            let historyLabel = UILabel()
            historyLabel.text = $0
            historyLabel.font = UIFont.systemFont(ofSize: 20)
            historyLabel.numberOfLines = 0
            historyLabel.textAlignment = .right
            historyLabel.lineBreakMode = .byWordWrapping
            
            
            historyStackView.addArrangedSubview(historyLabel)
        }
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

import SwiftUI
#Preview {
    return CalculatorHistoryVC()
}
