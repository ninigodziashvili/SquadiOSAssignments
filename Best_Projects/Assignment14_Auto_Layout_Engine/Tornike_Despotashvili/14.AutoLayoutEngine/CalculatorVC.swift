import UIKit


final class CalculatorVC: UIViewController {
    private let resultsView = UIView()
    
    private let firstLabel = UILabel()
    private var secondLabel = UILabel()
    
    let gradientLayr = CAGradientLayer()
    
    private let pad = UIView()
    
    private let mainNumStackView = UIStackView()
    private let firstNumbersStack = UIStackView()
    private let secondNumbersStack = UIStackView()
    private let thirdNumbersStack = UIStackView()
    private let fourthNumbersStack = UIStackView()
    private let fifthNumbersStack = UIStackView()
    private let bottomTwoLinesStack = UIStackView()
    
    private let button0 = CalcButton()
    private let button1 = CalcButton()
    private let button2 = CalcButton()
    private let button3 = CalcButton()
    private let button4 = CalcButton()
    private let button5 = CalcButton()
    private let button6 = CalcButton()
    private let button7 = CalcButton()
    private let button8 = CalcButton()
    private let button9 = CalcButton()
    private let dotButton = CalcButton()
    private let themeButton = CalcButton()
    private let percentIcon = CalcButton(value: "%")
    private let divideIcon = CalcButton(value: "/")
    private let mulitpleIcon = CalcButton(value: "*")
    private let decrementIcon = CalcButton(value: "-")
    private let incrementIcon = CalcButton(value: "+")
    private let acButton = CalcButton()
    private let resultButton = CalcButton()
    
    private var isDarkMode = false
    private var isCalculatedResult = false
    private var lastOperations: [String] = []
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        gradientLayr.frame = resultButton.bounds
        //        addShadow()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //        setupMainNumStackView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradinetColor()
        //        addShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func changeThemeMode() {
        isDarkMode = !isDarkMode
        
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
            
        }
        
        updateUI()
    }
    
    private func setupUI(){
        switch traitCollection.userInterfaceStyle {
        case .light:
            isDarkMode = false
        case .dark:
            isDarkMode = true
        default:
            isDarkMode = false
        }
        
        changeThemeMode()
        setupResultsView()
        setupLabels()
        setupNumpad()
        setupMainNumStackView()
        addHorizontalStacks()
        setupButtons()
        setupStacks()
        gradinetColor()
        addShadow()
    }
    
    private func setupLabels() {
        secondLabelSetup()
        firstLabelSetup()
    }
    
    private func setupResultsView() {
        view.addSubview(resultsView)
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            resultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func firstLabelSetup() {
        resultsView.addSubview(firstLabel)
        firstLabel.text = ""
        firstLabel.font = UIFont.systemFont(ofSize: 20)
        firstLabel.textColor = UIColor(hue: 235/360, saturation: 0.05, brightness: 0.84, alpha: 1)
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.trailingAnchor.constraint(equalTo: secondLabel.trailingAnchor).isActive = true
        firstLabel.bottomAnchor.constraint(equalTo: secondLabel.topAnchor, constant: -8).isActive = true
    }
    
    private func secondLabelSetup() {
        resultsView.addSubview(secondLabel)
        
        secondLabel.text = "0"
        secondLabel.font = UIFont.systemFont(ofSize: 48)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondLabel.trailingAnchor.constraint(equalTo: resultsView.trailingAnchor, constant: -43).isActive = true
        secondLabel.bottomAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: -40).isActive = true
    }
    
    private func setupNumpad() {
        view.addSubview(pad)
        
        pad.translatesAutoresizingMaskIntoConstraints = false
        pad.clipsToBounds = true
        pad.layer.cornerRadius = 28
        pad.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        NSLayoutConstraint.activate([
            pad.topAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: 16),
            pad.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            pad.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            pad.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupMainNumStackView() {
        pad.addSubview(mainNumStackView)
        
        mainNumStackView.translatesAutoresizingMaskIntoConstraints = false
        mainNumStackView.axis = .horizontal
        mainNumStackView.distribution = .fillEqually
        mainNumStackView.spacing = 16
        
        NSLayoutConstraint.activate([
            mainNumStackView.leftAnchor.constraint(equalTo: pad.leftAnchor, constant: 42),
            mainNumStackView.rightAnchor.constraint(equalTo: pad.rightAnchor, constant: -42),
            mainNumStackView.topAnchor.constraint(equalTo: pad.topAnchor, constant: 48),
            mainNumStackView.bottomAnchor.constraint(equalTo: pad.bottomAnchor, constant: -66)
        ])
    }
    
    private func addHorizontalStacks() {
        let stackArray = [firstNumbersStack, secondNumbersStack, thirdNumbersStack, fourthNumbersStack]
        
        stackArray.forEach { stack in
            stack.axis = .vertical
            stack.spacing = 16
            
            mainNumStackView.addArrangedSubview(stack)
        }
    }
    
    private func setupButtons() {
        acButton.setupButtonsUI(name: "AC")
        button0.setupButtonsUI(name: "0")
        button1.setupButtonsUI(name: "1")
        button2.setupButtonsUI(name: "2")
        button3.setupButtonsUI(name: "3")
        button4.setupButtonsUI(name: "4")
        button5.setupButtonsUI(name: "5")
        button6.setupButtonsUI(name: "6")
        button7.setupButtonsUI(name: "7")
        button8.setupButtonsUI(name: "8")
        button9.setupButtonsUI(name: "9")
        dotButton.setupButtonsUI(name: ".")
        resultButton.setupButtonsUI(name: "=")
        
        let buttonsArray: [CalcButton] = [
            button0,
            button1,
            button2,
            button3,
            button4,
            button5,
            button6,
            button7,
            button8,
            button9,
            dotButton,
            acButton,
            percentIcon,
            divideIcon,
            mulitpleIcon,
            decrementIcon,
            incrementIcon
        ]
        
        themeButton.addTarget(self, action: #selector(changeThemeMode), for: .touchUpInside)
        
        for button in buttonsArray {
            button.addAction(UIAction(handler: { [weak self] action  in
                self?.addButtonAction(value: button.value )
            }), for: .touchUpInside)
        }
        
        resultButton.addAction(UIAction(handler: { [weak self] action  in
            self?.useCalculator()
        }), for: .touchUpInside)
        
    }
    
    private func updateUI() {
        view.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.15, brightness: 0.15, alpha: 1) : UIColor.white
        
        pad.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.15, brightness: 0.18, alpha: 1) : UIColor(hue: 0/360, saturation: 0, brightness: 0.96, alpha: 1)
        
        updateButtonIconsColor()
        updateButtonTitleColor()
    }
    
    private func updateButtonIconsColor() {
        themeButton.setupButtonsUI(isDarkMode: isDarkMode, isBordered: true, iconLight: "sun", iconDark: "moon")
        percentIcon.setupButtonsUI(isDarkMode: isDarkMode, isFilled:true, iconLight: "percentLight", iconDark: "percentSvg")
        divideIcon.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "divideLight", iconDark: "divideSvg")
        mulitpleIcon.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "multipleLight", iconDark: "multipleSvg")
        incrementIcon.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "incrementLight", iconDark: "increment")
        decrementIcon.setupButtonsUI(isDarkMode:isDarkMode, isFilled: true, iconLight: "decrementLight", iconDark: "decrement")
    }
    
    private func updateButtonTitleColor() {
        button0.updatetextColor(isDarkMode: isDarkMode)
        button1.updatetextColor(isDarkMode: isDarkMode)
        button2.updatetextColor(isDarkMode: isDarkMode)
        button3.updatetextColor(isDarkMode: isDarkMode)
        button4.updatetextColor(isDarkMode: isDarkMode)
        button5.updatetextColor(isDarkMode: isDarkMode)
        button6.updatetextColor(isDarkMode: isDarkMode)
        button7.updatetextColor(isDarkMode: isDarkMode)
        button8.updatetextColor(isDarkMode: isDarkMode)
        button9.updatetextColor(isDarkMode: isDarkMode)
        acButton.updatetextColor(isDarkMode: isDarkMode)
        dotButton.updatetextColor(isDarkMode: isDarkMode)
    }
    
    private func setupStacks() {
        let firstLine = [themeButton, button7, button4, button1, acButton]
        firstLine.forEach { button in
            firstNumbersStack.addArrangedSubview(button)
            firstNumbersStack.distribution = .fillEqually
        }
        
        let secondLine = [percentIcon, button8, button5, button2, button0]
        secondLine.forEach { button in
            secondNumbersStack.addArrangedSubview(button)
            secondNumbersStack.distribution = .fillEqually
        }
        
        let thirdLine = [divideIcon, button9, button6, button3, dotButton]
        thirdLine.forEach { button in
            thirdNumbersStack.addArrangedSubview(button)
            thirdNumbersStack.distribution = .fillEqually
        }
        
        let fourthLine = [mulitpleIcon, decrementIcon, incrementIcon, resultButton]
        fourthLine.forEach { button in
            fourthNumbersStack.addArrangedSubview(button)
            fourthNumbersStack.distribution = .fillProportionally
            fourthNumbersStack.spacing = 18
        }
    }
    
    private func gradinetColor() {
        gradientLayr.frame = resultButton.bounds
        gradientLayr.cornerRadius = resultButton.layer.cornerRadius
        gradientLayr.colors = [
            UIColor(hue: 323/360, saturation: 0.94, brightness: 0.93, alpha: 1).cgColor,
            UIColor(hue: 13/360, saturation: 0.82, brightness: 1, alpha: 1).cgColor,
        ]
        
        resultButton.layer.insertSublayer(gradientLayr, at: 0)
    }
    
    private func addShadow() {
        resultButton.layer.shadowColor = UIColor(hue: 351/360, saturation: 0.76, brightness: 0.97, alpha: 0.8).cgColor
        resultButton.layer.shadowOpacity = 1
        resultButton.layer.shadowRadius = 6
        resultButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        resultButton.layer.masksToBounds = false
    }
    
    
    
    
    
    private func useCalculator() {
        guard let resText = secondLabel.text else { return }
        
        let expn = NSExpression(format: resText)
        
        firstLabel.text = String(describing: secondLabel.text ?? "")
        secondLabel.text = String(reflecting: expn.expressionValue(with: nil, context: nil) ?? "0")
        
        isCalculatedResult = true
        lastOperations.append(firstLabel.text ?? "")
    }
    
    private func addButtonAction(value: String) {
        let symbols = ["%", "/", "*",  "-", "+", "."]
        
        if symbols.contains(String(secondLabel.text?.last ?? ".")) && symbols.contains(value) {
            let droppedWord = secondLabel.text!.dropLast()
            secondLabel.text = String(Substring(droppedWord))
        }
        
        if value == "AC" {
            secondLabel.text = "0"
        } else if secondLabel.text == "0" || isCalculatedResult && !symbols.contains(value) {
            secondLabel.text! = value
            isCalculatedResult = false
        } else {
            secondLabel.text! += value
            isCalculatedResult = false
        }
    }
}





#Preview {
    let vc = CalculatorVC()
    return vc
}


