//
//  ViewController.swift
//  Assignment11
//
//  Created by Giorgi on 06.10.24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lableForSwithcer: UILabel?
    @IBOutlet weak var firstNumber: UITextField!
    @IBOutlet weak var secondNumber: UITextField!
    @IBOutlet weak var answearText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switcher(_ sender: Any) {
        changeLable()
    }
    
    private func changeLable() {
        if lableForSwithcer?.text == "უნაშთო გაყოფა" {
            lableForSwithcer?.text = "ნაშთიანი გაყოფა"
        } else {
            lableForSwithcer?.text = "უნაშთო გაყოფა"
        }
    }
    
    @IBAction private func calculate(_ sender: Any) {
        guard let num1 = Double(firstNumber.text!), let num2 = Double(secondNumber.text!) else {return}
        if num2 == 0 {
            answearText.text = "ნულზე გაყოფა არ შეიძლება"
            return
        }
        var result: Double
        if lableForSwithcer?.text == "უნაშთო გაყოფა" {
            result = num1 / num2
        } else {
            result = Double(Int(num1) % Int(num2))
        }
        answearText.text = "პასუხი: \(result)"
    }
    
    @IBAction private func themeChanger(_ sender: Any) {
        if overrideUserInterfaceStyle == .dark {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .dark
        }
    }
}

