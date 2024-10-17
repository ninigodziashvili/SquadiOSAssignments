//
//  CalculatorVC.swift
//  TBC-Assignment-14
//
//  Created by irakli kharshiladze on 12.10.24.
//

import UIKit


final class CalculatorVC: UIViewController {
    private var isDark: Bool = false
    private let gradient = CAGradientLayer()
    private let numberTitles = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "AC"]
    private let operationImages = ["percent", "divide", "multiply", "minus", "plus", "equal", "moon"]
    private var numberButtons: [NumberBtns] = []
    private var operationButtons: [OperationBtns] = []
    private var firstNumber: String = ""
    private var secondNumber: String = ""
    private var equation: String = ""
    private var calculatorHistory: [String] = []
    
    private enum Operation: String {
        case none = ""
        case divide = "/"
        case percent = "%"
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        
        var description: String {
                self.rawValue
            }
    }
    
    private let resultsView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let historyButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        button.setImage(UIImage(systemName: "clock.arrow.circlepath", withConfiguration: config), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private var historyLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        
        return label
    }()
    
    private var resultLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)

        return label
    }()
    
    private let numbersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    private let numbersStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
       stackView.axis = .horizontal
       stackView.distribution = .fillEqually
       stackView.spacing = 16
        
       return stackView
    }()
    
    private let firstColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .vertical
       stackView.distribution = .fillEqually
       stackView.spacing = 16

       return stackView
    }()
    
    private let secondColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
       return stackView
    }()
    
    private let thirdColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
       return stackView
    }()
    
    private let fourthColStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        
       return stackView
    }()
    
    private let threeBtnStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let equalBtnStackView: UIStackView = {
       let stackView = UIStackView()
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewWillLayoutSubviews()
        
        
        for (index, title) in numberTitles.enumerated() {
            let button = NumberBtns(buttonTitle: title, buttonTag: index)
            numberButtons.append(button)
        }
        
        for (index, image) in operationImages.enumerated() {
            let button = OperationBtns(buttonImage: image, buttonTag: index)
            operationButtons.append(button)
        }
        
        setupUI()
    }
    
    private func setupUI() {
        setupResultsView()
        setupResultsStackView()
        setupHistoryLbl()
        setupResultLbl()
        setupNumbersView()
        setupNumbersStackView()
        setupNumbersColStackView()
        setupBtns()
    }
    
    
    private func setupResultsView() {
        view.addSubview(resultsView)
        
        NSLayoutConstraint.activate([
            resultsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            resultsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            resultsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ])
        
    }
    
    private func setupResultsStackView() {
        resultsView.addSubview(resultsStackView)
        
        NSLayoutConstraint.activate([
            resultsStackView.rightAnchor.constraint(equalTo: resultsView.rightAnchor, constant: -33),
            resultsStackView.bottomAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: -40)
        ])
        
    }
    
    private func setupHistoryButton() {
        resultsView.addSubview(historyButton)
        
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: resultsView.topAnchor, constant: 47),
            historyButton.leftAnchor.constraint(equalTo: resultsView.leftAnchor, constant: 15)
        ])

        historyButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigateToHistoryPage()
        }), for: .touchUpInside)
    }
    
    private func navigateToHistoryPage() {
        let vc = CalculatorHistoryVC()
         
        vc.isDark = isDark
        vc.calculatorHistory = calculatorHistory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupHistoryLbl() {
        resultsStackView.addArrangedSubview(historyLbl)
        historyLbl.text = ""
    }
    
    private func setupResultLbl() {
        resultsStackView.addArrangedSubview(resultLbl)
        resultLbl.text = ""
    }
    
    private func setupNumbersView() {
        view.addSubview(numbersView)
        
        NSLayoutConstraint.activate([
            numbersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            numbersView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            numbersView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            numbersView.heightAnchor.constraint(equalTo: resultsView.heightAnchor, multiplier: 1.5),
            numbersView.topAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupNumbersStackView() {
        numbersView.addSubview(numbersStackView)
        
        NSLayoutConstraint.activate([
            numbersStackView.rightAnchor.constraint(equalTo: numbersView.rightAnchor, constant: -33),
            numbersStackView.leftAnchor.constraint(equalTo: numbersView.leftAnchor, constant: 33),
            numbersStackView.topAnchor.constraint(equalTo: numbersView.topAnchor, constant: 30),
            numbersStackView.bottomAnchor.constraint(equalTo: numbersView.bottomAnchor, constant: -36)
        ])
    }
    
    private func setupNumbersColStackView() {
        [firstColStackView, secondColStackView, thirdColStackView, fourthColStackView].forEach { numbersStackView.addArrangedSubview($0) }
        setupThreeBtnStackView()
        setupEqualBtnStackView()
    }
    
    private func setupThreeBtnStackView() {
        fourthColStackView.addArrangedSubview(threeBtnStackView)
    }
    
    private func setupEqualBtnStackView() {
        fourthColStackView.addArrangedSubview(equalBtnStackView)
        equalBtnStackView.heightAnchor.constraint(equalTo: threeBtnStackView.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    
    private func setupBtns() {
        [operationButtons[6], numberButtons[7], numberButtons[4], numberButtons[1], numberButtons[11]].forEach { firstColStackView.addArrangedSubview($0) }
        
        [operationButtons[0], numberButtons[8], numberButtons[5], numberButtons[2], numberButtons[0]].forEach { secondColStackView.addArrangedSubview($0) }
        
        [operationButtons[1], numberButtons[9], numberButtons[6], numberButtons[3], numberButtons[10]].forEach { thirdColStackView.addArrangedSubview($0) }
        
        [operationButtons[2], operationButtons[3], operationButtons[4]].forEach { threeBtnStackView.addArrangedSubview($0) }

        equalBtnStackView.addArrangedSubview(operationButtons[5])
        
        //MARK: digit buttons
        numberButtons.forEach {
            $0.addAction(UIAction(handler: { [weak self] action in
                if let button = action.sender as? UIButton {
                        switch button.tag {
                        case 0..<10:
                            self?.addDigitToEquation(tag: button.tag)
                        case 10:
                            self?.addDotToEquation()
                        case 11:
                            self?.resetCalculator()
                        default:
                            return
                        }
                    }
            }), for: .touchUpInside)
        }
        
        //MARK: operation buttons
        [operationButtons[0], operationButtons[1], operationButtons[2], operationButtons[3], operationButtons[4]].forEach {
            $0.addAction(UIAction(handler: { [weak self] action in
                if let button = action.sender as? UIButton {
                        switch button.tag {
                        case 1..<7:
                            self?.addOperationToEquation(operationTag: button.tag)
                        case 0:
                            self?.calculatePercentage()
                        default:
                            return
                        }
                    }
            }), for: .touchUpInside)
        }
        
        setupThemeSwitchBtn()
        setupEqualBtn()
        setupHistoryButton()
    }
    
    private func addDotToEquation() {
        equation.append(".")
        resultLbl.text = equation
    }
    
    private func addOperationToEquation(operationTag: Int) {
        switch operationTag {
        case 0:
            equation.append(Operation.percent.description)
            resultLbl.text = equation
        case 1:
            equation.append(Operation.divide.description)
            resultLbl.text = equation
        case 2:
            equation.append(Operation.multiply.description)
            resultLbl.text = equation
        case 3:
            equation.append(Operation.minus.description)
            resultLbl.text = equation
        case 4:
            equation.append(Operation.plus.description)
            resultLbl.text = equation
        default:
            return
        }
    }
    
    private func addDigitToEquation(tag: Int) {
        equation.append(String(tag))
        resultLbl.text = equation
    }
    
    private func setupThemeSwitchBtn() {
        operationButtons[6].addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        operationButtons[6].clipsToBounds = true
        operationButtons[6].backgroundColor = .none
        operationButtons[6].tintColor = .red
        operationButtons[6].layer.borderWidth = 1
        operationButtons[6].layer.cornerRadius = 33
        operationButtons[6].layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    @objc private func changeTheme() {
        isDark.toggle()
        
        operationButtons[6].setImage(UIImage(systemName: isDark ? "sun.max" : "moon"), for: .normal)
        view.overrideUserInterfaceStyle = isDark ? .dark : .light
        view.backgroundColor = isDark ? .systemFill : .white
        historyButton.tintColor = isDark ? .white : .black
    }
    
    private func setupEqualBtn() {
        operationButtons[5].layer.shadowColor = UIColor(red: 247/255, green: 60/255, blue: 87/255, alpha: 1).cgColor
        operationButtons[5].layer.shadowOffset = .zero
        operationButtons[5].layer.shadowOpacity = 0.7
        operationButtons[5].layer.shadowRadius = 10.0
        operationButtons[5].layer.masksToBounds = false
        
        operationButtons[5].addAction(UIAction(handler: { [weak self] action in
            self?.calculateEquation()
        }), for: .touchUpInside)
        
        applyGradient()
    }
    
    private func calculatePercentage() {
     resultLbl.text = "\((Double(equation) ?? 0) / 100.0)"
     historyLbl.text = "\(equation) %"
     calculatorHistory.append(historyLbl.text ?? "")
     equation = ""
    }
    
    private func calculateEquation() {
        let digitSet = CharacterSet.decimalDigits
        let equationContainsDigits = equation.rangeOfCharacter(from: digitSet) != nil
        
        if !equationContainsDigits {
            resultLbl.text = "0"
            calculatorHistory.append("\(equation) = 0")
            equation = ""
            return
        }
           
        let expression = NSExpression(format: equation != "" ? equation : "0")
        guard let result = expression.expressionValue(with: nil, context: nil) as? NSNumber else {
            resultLbl.text = "Error"
            return
        }
        
        historyLbl.text = equation
        resultLbl.text = "\(result)"
        equation = "\(result)"
        calculatorHistory.append("\(historyLbl.text ?? "") = \(result)")
    }
    
    private func resetCalculator() {
        calculatorHistory.append("AC")
        resultLbl.text = ""
        historyLbl.text = ""
        equation = ""
    }
    
    private func applyGradient() {
        let colorOne = UIColor(red: 237/255, green: 14/255, blue: 152/255, alpha: 1.0)
        let colorTwo = UIColor(red: 254/255, green: 90/255, blue: 46/255, alpha: 1.0)
        
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.cornerRadius = 33
        operationButtons[5].layer.insertSublayer(gradient, below: operationButtons[5].imageView?.layer)
        updateGradientFrame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }
    
    private func updateGradientFrame() {
        gradient.frame = operationButtons[5].bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.updateGradientFrame()
        }, completion: nil)
    }
}

import SwiftUI
#Preview() {
    return CalculatorVC()
}
