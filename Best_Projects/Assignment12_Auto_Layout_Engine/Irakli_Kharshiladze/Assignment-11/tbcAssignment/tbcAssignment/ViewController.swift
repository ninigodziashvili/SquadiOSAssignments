//
//  ViewController.swift
//  tbcAssignment
//
//  Created by irakli kharshiladze on 06.10.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNumberInput: UITextField?
    @IBOutlet weak var secondNumberInput: UITextField?
    @IBOutlet weak var calculateBtn: UIButton?
    @IBOutlet weak var viewTitle: UILabel?
    @IBOutlet weak var result: UILabel?
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var divisionSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func toggleTheme(_ sender: UISwitch) {
        if sender .isOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
        guard let firstText = firstNumberInput?.text, let firstNumber = Double(firstText) else {
            result?.text = "შეიყვანეთ სწორი პირველი რიცხვი"
            return
        }
        
        guard let firstText = secondNumberInput?.text, let secondNumber = Double(firstText) else {
            result?.text = "შეიყვანეთ სწორი მეორე რიცხვი"
            return
        }
            
        if divisionSwitch.isOn {
            calculateCleanDivison(firstNumber: firstNumber, secondNumber: secondNumber)
        } else {
            calculateReminderDivision(firstNumber: Int(firstNumber), secondNumber: Int(secondNumber))
        }
    }
    
    private func setupUI() {
        firstNumberInput?.placeholder = "შეიყვანეთ გასაყოფი რიცხვი"
        secondNumberInput?.placeholder = "შეიყვანეთ გამყოფი რიცხვი"
        
        themeSwitch?.isOn = (traitCollection.userInterfaceStyle == .dark)
    }
    
    private func calculateCleanDivison(firstNumber: Double, secondNumber: Double) {
        
        if secondNumber == 0 {
            result?.text = "ნულზე გაყოფა არ შეიძლება"
        } else {
            result?.text = "პასუხი: \(firstNumber / secondNumber)"
        }
    }
    
    private func calculateReminderDivision(firstNumber: Int, secondNumber: Int) {
        
        if secondNumber == 0 {
            result?.text = "ნულზე გაყოფა არ შეიძლება"
        } else {
            result?.text = "პასუხი: ნაშთი \(firstNumber % secondNumber)"
        }
    }
}

