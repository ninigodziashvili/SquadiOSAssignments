//
//  ViewController.swift
//  Assignment11
//
//  Created by MacBook on 06.10.24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI Components
    
    @IBOutlet private weak var divisionTypeLabel: UILabel!
    @IBOutlet private weak var divisionTypeSwitch: UISwitch!
    @IBOutlet private weak var initialNumberTextField: UITextField!
    @IBOutlet private weak var dividerNumberTextField: UITextField!
    @IBOutlet private weak var calculateButton: UIButton!
    @IBOutlet private weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initialInterfaceSetup()
    }
    
    //MARK: Action Performers
    
    @IBAction private func divisionTypeSwitchTapped() {
        modifyDivisionTypeLabel()
    }
    
    @IBAction private func calculateButtonTapped() {
        calculateDivisions()
        view.endEditing(true)
    }
    
    //MARK: Additional Functionals
    
    private func initialInterfaceSetup() {
        divisionTypeSwitch.isOn = false
        modifyDivisionTypeLabel()
        initialNumberTextField.placeholder = "გასაყოფი"
        dividerNumberTextField.placeholder = "გამყოფი"
        calculateButton.setTitle("გამოთვლა", for: .normal)
        resultsLabel.text = ""
        resultsLabel.textAlignment = .center
        updateLabelColors()
    }
    
    private func modifyDivisionTypeLabel() {
        switch divisionTypeSwitch.isOn {
        case true:
            divisionTypeLabel.text = "ნაშთიანი გაყოფა"
        case false:
            divisionTypeLabel.text = "უნაშთო გაყოფა"
        }
    }
    
    private func divide(primalNumber: Int, dividerNumber: Int) -> Double{
        Double(primalNumber / dividerNumber)
    }
    
    private func divideModully(primalNumber: Int, dividerNumber: Int) -> Int {
        primalNumber % dividerNumber
    }
    
    
    private func calculateDivisions() {
        if let initialText = initialNumberTextField.text, !initialText.isEmpty,
           let dividerText = dividerNumberTextField.text, !dividerText.isEmpty,
           let primalNumber = Int(initialText),
           let dividerNumber = Int(dividerText) {
            
            if dividerNumber == 0 {
                resultsLabel.text = "ნულზე გაყოფა არ შეიძლება"
                return
            }
            
            switch divisionTypeSwitch.isOn {
            case true:
                resultsLabel.text = "\(divideModully(primalNumber: primalNumber, dividerNumber: dividerNumber))"
            case false:
                resultsLabel.text = "\(divide(primalNumber: primalNumber, dividerNumber: dividerNumber))"
            }
        }
    }
    
    // MARK: Extra Initiatives (Hopefully it's okay)
    
    private func updateLabelColors() {
        if traitCollection.userInterfaceStyle == .dark {
            divisionTypeLabel.textColor = .white
            resultsLabel.textColor = .white
        } else {
            divisionTypeLabel.textColor = .black
            resultsLabel.textColor = .black
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateLabelColors()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

