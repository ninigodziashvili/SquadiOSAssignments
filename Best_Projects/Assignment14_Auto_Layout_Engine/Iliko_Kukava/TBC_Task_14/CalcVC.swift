//
//  CalcVC.swift
//  TBC_Task_14
//
//  Created by iliko on 10/13/24.
//
import UIKit


class CalcVC: UIViewController {
    
    // MARK: - UI Components
    
    private let semiRoundedView = UIView()
    private var currentMode: Mode = .light
    private var buttonsDict = [String: UIButton]()
    private var mainStack: UIStackView!
    private var rowStack: UIStackView!
    
    var labelOne: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var labelTwo: UILabel = {
        let label = UILabel()
        return label
    }()
    
    enum Mode {
        case light
        case dark
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        setupUI()
        setupCalculator()
        customizingModeChangeButton()
        customizingButtonAC()
        customizingActionButtons(for: ["％", "÷", "✕", "－", "+"])
        customizingOperatorButtons(for: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."])
        customizingEqualButton()
    }
    
    // MARK: - UI Setup
    
    private func updateBackgroundColor() {
        switch currentMode {
        case .light:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = .black
        }
    }
    
    private func setupUI() {
        setupLabelOne()
        setupLabelTwo()
        setupSemiRoundedView()
    }
    
    private func setupLabelOne() {
        view.addSubview(labelOne)
        labelOne.text = "120 x 3 + 608 + 1080"
        labelOne.textColor = .black
        labelOne.textAlignment = .right
        labelOne.font = UIFont.systemFont(ofSize: 20, weight: .light)
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelOne.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            labelOne.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            labelOne.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setupLabelTwo() {
        view.addSubview(labelTwo)
        labelTwo.text = "2,048"
        labelTwo.textColor = .black
        labelTwo.textAlignment = .right
        labelTwo.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 8),
            labelTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    private func setupSemiRoundedView() {
        semiRoundedView.layer.cornerRadius = 30
        semiRoundedView.backgroundColor = UIColor.systemGray5
        view.addSubview(semiRoundedView)
        semiRoundedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            semiRoundedView.widthAnchor.constraint(equalTo: view.widthAnchor),
            semiRoundedView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            semiRoundedView.leftAnchor.constraint(equalTo: view.leftAnchor),
            semiRoundedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: - setup Calculator
    
    private func setupCalculator() {
        let buttonTitles: [[String]] = [
            ["☼", "7", "4", "1", "AC"],
            ["％", "8", "5", "2", "0"],
            ["÷", "9", "6", "3", "."],
            ["✕", "－", "+", "="],
        ]
        
        mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.distribution = .equalSpacing
        mainStack.spacing = 10
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        for row in buttonTitles {
            rowStack = UIStackView()
            rowStack.axis = .vertical
            rowStack.distribution = .fillProportionally
            rowStack.spacing = 6
            rowStack.alignment = .fill
            
            for buttonTitle in row {
                let button = createRoundedButton(with: buttonTitle)
                rowStack.addArrangedSubview(button)
                
                buttonsDict[buttonTitle] = button
            }
            mainStack.addArrangedSubview(rowStack)
        }
        
        semiRoundedView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: semiRoundedView.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: semiRoundedView.centerYAnchor)
        ])
    }
    
    // MARK: - creating custom Buttons
    
    private func createRoundedButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        DispatchQueue.main.async {
            button.layer.cornerRadius = button.frame.height / 2
        }
        return button
    }
    

    // MARK: - customizing Buttons
    
    private func customizingModeChangeButton() {
        if let button = buttonsDict["☼"] {
            button.setTitleColor(.systemPink, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 50 , weight: .bold)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        if let modeChangeButton = buttonsDict["☼"] {
            modeChangeButton.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        }
    }
    
    private func customizingButtonAC() {
        if let button = buttonsDict["AC"] {
            button.setTitleColor(.systemPink, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        }
    }
    
    private func customizingActionButtons(for titles: [String]) {
        for title in titles {
            if let button = buttonsDict[title] {
                button.backgroundColor = .lightGray
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 30 , weight: .semibold)
            }
        }
    }
    
    private func customizingOperatorButtons(for titles: [String]) {
        for title in titles {
            if let button = buttonsDict[title] {
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 24 , weight: .semibold)
            }
        }
    }
    
    private func customizingEqualButton() {
        if let button = buttonsDict["="] {
            button.layoutIfNeeded()
            DispatchQueue.main.async {
                button.heightAnchor.constraint(equalToConstant: 140).isActive = true
                button.layer.cornerRadius = button.frame.height / 4
            }
            button.clipsToBounds = true

            if let oldGradientLayer = button.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
                oldGradientLayer.removeFromSuperlayer()
            }

            let equalGradientLayer = CAGradientLayer()
            equalGradientLayer.frame = button.bounds

            if let color1 = UIColor(hex: "#ED0E98"), let color2 = UIColor(hex: "#FE5A2D") {
                equalGradientLayer.colors = [color1.cgColor, color2.cgColor]
            }

            equalGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            equalGradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

            button.layer.insertSublayer(equalGradientLayer, at: 0)
        }
    }
    
    // MARK: - light and dark Mode
    
    @objc private func changeMode() {
        currentMode = (currentMode == .light) ? .dark : .light
        updateBackgroundColor()
    
        labelOne.textColor = (currentMode == .light) ? .black : .white
        labelTwo.textColor = (currentMode == .light) ? .black : .white
        semiRoundedView.backgroundColor = (currentMode == .light) ? UIColor.systemGray5 : UIColor.darkGray
        
        if let button = buttonsDict["☼"] {
            button.setTitle(currentMode == .light ? "☼" : "☾", for: .normal)
        }
                                                           
        changeModeButtons(for: ["％", "÷", "✕", "－", "+"])
        changeModeButtons(for: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."])
        }
    
    private func changeModeButtons(for titles: [String]) {
        for title in titles {
            if let button = buttonsDict[title] {
                button.setTitleColor((currentMode == .light) ? .black : .white, for: .normal)
            }
        }
    }
    
    // MARK: - still working on layout rotation . . .
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.adjustLayout(for: size)
        }, completion: nil)
    }
    
    private func adjustLayout(for size: CGSize) {
        
        if size.width > size.height {
            DispatchQueue.main.async {
                self.mainStack.distribution = .fillEqually
                self.mainStack.spacing = 2

                self.rowStack.distribution = .fillEqually
                self.rowStack.spacing = 2
                
                self.mainStack.translatesAutoresizingMaskIntoConstraints = false
                self.rowStack.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    self.mainStack.leadingAnchor.constraint(equalTo: self.semiRoundedView.leadingAnchor, constant: 16),
                    self.mainStack.trailingAnchor.constraint(equalTo: self.semiRoundedView.trailingAnchor, constant: -16),
                    self.mainStack.topAnchor.constraint(equalTo: self.semiRoundedView.topAnchor, constant: 16),
                    self.mainStack.bottomAnchor.constraint(equalTo: self.semiRoundedView.bottomAnchor, constant: -16)
                       ])
            }
        } else {
            DispatchQueue.main.async {
                self.mainStack.distribution = .equalSpacing
                self.mainStack.alignment = .fill
                self.mainStack.spacing = 10

                self.rowStack.distribution = .fillEqually
                self.rowStack.alignment = .firstBaseline

                self.rowStack.spacing = 2
                
                self.mainStack.translatesAutoresizingMaskIntoConstraints = false
                self.rowStack.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    self.mainStack.centerXAnchor.constraint(equalTo: self.semiRoundedView.centerXAnchor),
                    self.mainStack.centerYAnchor.constraint(equalTo: self.semiRoundedView.centerYAnchor)
                ])
            }
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - custom color - Linear.

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}























// MARK: - SwiftUI for live update

import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> CalcVC {
        return CalcVC()
    }
    
    func updateUIViewController(_ uiViewController: CalcVC, context: Context) {
    }
}

struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ViewControllerPreview()
}
