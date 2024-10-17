//
//  ViewController.swift
//  Assignement13
//
//  Created by Sandro Tsitskishvili on 13.10.24.
//

import UIKit

protocol HistoryDelegate: AnyObject {
    func didAddToHistory(_ calculation: String)
}

final class ProfileVC: UIViewController, HistoryDelegate {
    
    private let numbersLabel = UILabel()
    private let numbersSumLabel = UILabel()
    private let backgroundStack = UIStackView()
    private let historyButton = UIButton(type: .system)
    private var history: [String] = []
    
    private var currentInput: String = ""
    private var previousInput: String = ""
    private var selectedOperation: String?
    private var isDarkMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureHistoryButton()
        
    }
    
    private func setupUI() {
        setupNumbersLabel()
        setupNumbersSumLabel()
        setupBackgroundStack()
        setupCalculatorButtons()
    }
    
    private func setupNumbersLabel() {
        view.addSubview(numbersLabel)
        let positionOfLabel = CGPoint(x:200, y:193)
        let sizeofLabel = CGSize(width: 160, height: 30)
        numbersLabel.frame = CGRect(origin: positionOfLabel, size: sizeofLabel)
        numbersLabel.textColor = .label
        numbersLabel.text = "120 x 3 +608 +1080"
        numbersLabel.adjustsFontSizeToFitWidth = true
        numbersLabel.textAlignment = .right
        numbersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        numbersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        numbersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        numbersLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupNumbersSumLabel() {
        view.addSubview(numbersSumLabel)
        let positionOfLabel = CGPoint(x:200, y:233)
        let sizeofLabel = CGSize(width: 180, height: 50)
        numbersSumLabel.frame = CGRect(origin: positionOfLabel, size: sizeofLabel)
        numbersSumLabel.textColor = .label
        numbersSumLabel.text = "2,048"
        numbersSumLabel.adjustsFontSizeToFitWidth = true
        numbersSumLabel.textAlignment = .center
        numbersSumLabel.font = UIFont.systemFont(ofSize: 60, weight:.bold)
        numbersSumLabel.translatesAutoresizingMaskIntoConstraints = false
        numbersSumLabel.topAnchor.constraint(equalTo: numbersLabel.bottomAnchor, constant: 10).isActive = true
        numbersSumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200).isActive = true
        numbersSumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        numbersSumLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupBackgroundStack() {
        view.addSubview(backgroundStack)
        let positionOfStack = CGPoint(x:-5, y:350)
        let sizeofStack = CGSize(width: 400, height: 500)
        backgroundStack.backgroundColor = .systemGray5
        backgroundStack.frame = CGRect(origin: positionOfStack, size: sizeofStack)
        backgroundStack.axis = .horizontal
        backgroundStack.distribution = .fillEqually
        backgroundStack.spacing = 10
        backgroundStack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        backgroundStack.isLayoutMarginsRelativeArrangement = true
        
        let cornerRadius: CGFloat = 20.0
        backgroundStack.layer.cornerRadius = cornerRadius
        backgroundStack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundStack.layer.masksToBounds = true
        backgroundStack.topAnchor.constraint(equalTo: numbersSumLabel.bottomAnchor, constant: 20).isActive = true
        backgroundStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5).isActive = true
        backgroundStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        backgroundStack.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    private func setupCalculatorButtons() {
        let buttonTitles: [[String]] = [
            ["Night", "7", "4", "1", "AC"],
            ["%", "8", "5", "2", "0"],
            ["÷", "9", "6", "3", "."],
            ["×", "-", "+", "=", ]
        ]
        for columnTitles in buttonTitles {
            let columnStack = UIStackView()
            columnStack.axis = .vertical
            columnStack.spacing = 10
            columnStack.distribution = .fillEqually
            
            for title in columnTitles {
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
                button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
                if title == "=" {
                    button.backgroundColor = .red
                    button.setTitleColor(.white, for: .normal)
                    button.layer.cornerRadius = 20
                    button.clipsToBounds = true
                    button.translatesAutoresizingMaskIntoConstraints = false
                    columnStack.addArrangedSubview(button)
                    button.heightAnchor.constraint(equalToConstant: 80).isActive = true
                    button.widthAnchor.constraint(equalToConstant: 120).isActive = true
                } else if title == "Night" {
                    button.setTitleColor(.red, for: .normal)
                    button.backgroundColor = .systemGray5
                    button.layer.borderWidth = 2
                    button.layer.cornerRadius = 35
                    button.clipsToBounds = true
                } else if title == "AC" {
                    button.setTitleColor(.red, for: .normal)
                    button.backgroundColor = .clear
                    button.layer.cornerRadius = 0
                    button.clipsToBounds = false
                } else if ["%", "÷", "×", "-", "+"].contains(title) {
                    button.backgroundColor = .systemGray4
                    button.setTitleColor(.black, for: .normal)
                    button.layer.cornerRadius = 35
                    button.clipsToBounds = true
                } else {
                    button.backgroundColor = .clear
                    button.setTitleColor(.black, for: .normal)
                    button.layer.cornerRadius = 0
                    button.clipsToBounds = false
                }
                columnStack.addArrangedSubview(button)
            }
            backgroundStack.addArrangedSubview(columnStack)
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        switch title {
        case "AC":
            clearAll()
        case "÷", "×", "-", "+", "%":
            setOperation(title)
        case "=":
            calculateResult()
        case "Night":
            toggleDarkMode()
        default:
            appendToCurrentInput(title)
        }
    }
    
    private func clearAll() {
        currentInput = ""
        previousInput = ""
        selectedOperation = nil
        numbersLabel.text = "0"
        numbersSumLabel.text = "0"
        
        let clearHistoryEntry = "AC"
        history.append(clearHistoryEntry)
    }
    
    private func setOperation(_ operation: String) {
        if operation == "%" {
            if !currentInput.isEmpty {
                let percentageValue = (Double(currentInput) ?? 0) / 100
                numbersSumLabel.text = String(format: "%.2f", percentageValue)
                currentInput = ""
                previousInput = ""
            }
        } else {
            if !currentInput.isEmpty {
                if !previousInput.isEmpty {
                    numbersLabel.text = "\(previousInput) \(selectedOperation ?? "") \(currentInput)"
                } else {
                    numbersLabel.text = "\(currentInput) \(operation)"
                }
                selectedOperation = operation
                previousInput = currentInput
                currentInput = ""
            }
        }
    }
    
    private func appendToCurrentInput(_ value: String) {
        if let lastChar = previousInput.last, lastChar == "=" {
            previousInput = ""
            numbersLabel.text = ""
            currentInput = ""
        }
        currentInput += value
        numbersLabel.text = "\(previousInput) \(selectedOperation ?? "") \(currentInput)".trimmingCharacters(in: .whitespaces)
    }
    
    private func calculateResult() {
        guard let operation = selectedOperation, !previousInput.isEmpty, !currentInput.isEmpty else { return }
        
        let firstNumber = Double(previousInput) ?? 0
        let secondNumber = Double(currentInput) ?? 0
        var result: Double = 0
        
        switch operation {
        case "+":
            result = firstNumber + secondNumber
        case "-":
            result = firstNumber - secondNumber
        case "×":
            result = firstNumber * secondNumber
        case "÷":
            result = firstNumber / secondNumber
        default:
            return
        }
        
        let calculation = "\(firstNumber) \(operation) \(secondNumber) = \(result)"
        history.append(calculation)
        numbersSumLabel.text = String(format: "%.2f", result)
        numbersLabel.text = ""
        currentInput = ""
        previousInput = ""
        selectedOperation = nil
        
    }
    
    private func toggleDarkMode() {
        isDarkMode.toggle()
        updateUI()
    }
    
    private func updateUI() {
        if isDarkMode {
            view.backgroundColor = .black
            numbersLabel.textColor = .white
            numbersSumLabel.textColor = .white
            backgroundStack.backgroundColor = .darkGray
            historyButton.tintColor = .white
        } else {
            view.backgroundColor = .systemBackground
            numbersLabel.textColor = .label
            numbersSumLabel.textColor = .label
            backgroundStack.backgroundColor = .systemGray5
            historyButton.tintColor = .black
        }
    }
    
    private func configureHistoryButton() {
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(historyButton)
        historyButton.tintColor = isDarkMode ? .white : .black
        historyButton.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        historyButton.imageView?.contentMode = .scaleAspectFit
        historyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        historyButton.addAction(UIAction(handler: { [ weak self ] action in
            self?.historyButtonAction()
        }), for: .touchUpInside)
    }
    
    private func historyButtonAction() {
        let historyViewController = HistoryVC()
        historyViewController.history = history
        historyViewController.delegate = self
        historyViewController.isDarkMode = isDarkMode
        self.navigationController?.pushViewController(historyViewController, animated: true)
    }

    func didAddToHistory(_ calculation: String) {
        history.append(calculation)
    }
}




