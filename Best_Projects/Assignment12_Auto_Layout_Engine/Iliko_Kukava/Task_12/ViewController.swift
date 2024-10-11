//
//  ViewController.swift
//  Task_12
//
//  Created by iliko on 10/9/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var semiRoundedView: UIView!
    @IBOutlet private var calcAllButton: [UIButton]!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var modeChangeButton: UIButton!
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var buttonAC: UIButton!
    
    enum Mode {
        case light
        case dark
    }

    private var currentMode: Mode = .light
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedViewFunc()
        modifyAllButtons()
        modifyEqualButton()
        updateAppearance()
    }
    
    @IBAction private func modeChangeButton(_ sender: UIButton) {
        currentMode = (currentMode == .light) ? .dark : .light
        updateAppearance()
    }
    
    private func modifyAllButtons() {
        for button in calcAllButton {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
    }
    
    private func modifyEqualButton() {
        equalButton.layer.cornerRadius = equalButton.frame.size.height / 4
        
        let equalGradientLayer = CAGradientLayer()
        equalGradientLayer.frame = equalButton.bounds
        
        if let color1 = UIColor(hex: "#ED0E98"), let color2 = UIColor(hex: "#FE5A2D") {
            equalGradientLayer.colors = [color1.cgColor, color2.cgColor]
        }
        
        equalGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        equalGradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        equalButton.clipsToBounds = true
        equalButton.layer.insertSublayer(equalGradientLayer, at: 0)
    }
    
    private func updateAppearance() {
        switch currentMode {
        case .light:
            view.backgroundColor = .white
            semiRoundedView.backgroundColor = .systemGray6
            modeChangeButton.setTitle("☼", for: .reserved)
            firstLabel.textColor = .black
            secondLabel.textColor = .black
            for button in calcAllButton {
                button.setTitleColor(.black, for: .normal)
            }
            buttonAC.tintColor = .black
        case .dark:
            view.backgroundColor = .black
            semiRoundedView.backgroundColor = .darkGray
            modeChangeButton.setTitle("☾", for: .reserved)
            firstLabel.textColor = .white
            secondLabel.textColor = .white
            for button in calcAllButton {
                button.setTitleColor(.white, for: .normal)
            }
            buttonAC.tintColor = .systemPink
        }
    }
    
    private func roundedViewFunc() {
        semiRoundedView.layer.cornerRadius = 30
        semiRoundedView.clipsToBounds = true
    }
}

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




