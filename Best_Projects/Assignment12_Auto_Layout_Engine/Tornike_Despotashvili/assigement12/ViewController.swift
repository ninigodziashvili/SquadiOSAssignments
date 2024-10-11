//
//  ViewController.swift
//  assigement12
//
//  Created by Despo on 09.10.24.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var firstLabel: UILabel?
    @IBOutlet private weak var secondLabel: UILabel?
    @IBOutlet private weak var themeIcon: UIButton?
    @IBOutlet private weak var percentIcon: UIButton?
    @IBOutlet private weak var dividerIcon: UIButton?
    @IBOutlet private weak var multipleIcon: UIButton?
    @IBOutlet private weak var decrementIcon: UIButton?
    @IBOutlet private weak var incrementIcon: UIButton?
    @IBOutlet private weak var equalsButtons: UIButton?
    @IBOutlet private weak var acButton: UIButton?
    @IBOutlet private weak var number1: UIButton?
    @IBOutlet private weak var number2: UIButton?
    @IBOutlet private weak var number3: UIButton?
    @IBOutlet private weak var number4: UIButton?
    @IBOutlet private weak var number5: UIButton?
    @IBOutlet private weak var number6: UIButton?
    @IBOutlet private weak var number7: UIButton?
    @IBOutlet private weak var number8: UIButton?
    @IBOutlet private weak var number9: UIButton?
    @IBOutlet private weak var numPad: UIView!
    
    var isDarkMode = false
    let gradientLayr = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCustomButtons()
        gradientLayr.frame = equalsButtons!.bounds
    }
    
    @IBAction private func changeThemeColor() {
        isDarkMode = !isDarkMode
        setupInterface()

        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }

    private func setupUI() {
        switch traitCollection.userInterfaceStyle {
        case .light:
            isDarkMode = false
        case .dark:
            isDarkMode = true
        default:
            isDarkMode = false
        }
        
        setupInterface()
        gradinetColor()
        addShadow()
    }
    
    private func setupInterface() {
        setupNumPad()
        setupCustomButtons()

        view.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.15, brightness: 0.15, alpha: 1) : UIColor.white
        
        firstLabel?.textColor = isDarkMode ? UIColor(hue: 235/360, saturation: 0.05, brightness: 0.84, alpha: 1) : UIColor(hue: 208/360, saturation: 0.23, brightness: 0.51, alpha: 1)
    }
    
    private func setupNumPad() {
        numPad.translatesAutoresizingMaskIntoConstraints = false
        numPad.clipsToBounds = true
        numPad.layer.cornerRadius = 28
        numPad.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        numPad?.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.15, brightness: 0.18, alpha: 1) : UIColor(hue: 0/360, saturation: 0, brightness: 0.96, alpha: 1)
    }
    
    private func setupCustomButtons() {
        themeIcon?.borderedButton(isDarkMode: isDarkMode)
        themeIcon?.setImage(UIImage(named: isDarkMode ? "sunIcon" : "moonSvg"), for: .normal)
        
        percentIcon?.filledButton(isDarkMode: isDarkMode)
        percentIcon?.setImage(UIImage(named: isDarkMode ? "percentLight" : "percentSvg"), for: .normal)
        
        multipleIcon?.filledButton(isDarkMode: isDarkMode)
        multipleIcon?.setImage(UIImage(named: isDarkMode ? "multipleLight" : "multipleSvg"), for: .normal)
        
        dividerIcon?.filledButton(isDarkMode: isDarkMode)
        dividerIcon?.setImage(UIImage(named: isDarkMode ? "divideLight" : "divideSvg"), for: .normal)
        
        decrementIcon?.filledButton(isDarkMode: isDarkMode)
        decrementIcon?.setImage(UIImage(named: isDarkMode ? "decrementLight" : "decrement"), for: .normal)
        
        incrementIcon?.filledButton(isDarkMode: isDarkMode)
        incrementIcon?.setImage(UIImage(named: isDarkMode ? "incrementLight" : "increment"), for: .normal)
        
        equalsButtons?.layer.cornerRadius = 32
    }
    
    private func gradinetColor() {
        gradientLayr.frame = equalsButtons!.bounds
        gradientLayr.cornerRadius = 32
        gradientLayr.colors = [
            UIColor(hue: 323/360, saturation: 0.94, brightness: 0.93, alpha: 1).cgColor,
            UIColor(hue: 13/360, saturation: 0.82, brightness: 1, alpha: 1).cgColor,
        ]

        equalsButtons!.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        equalsButtons?.layer.addSublayer(gradientLayr)
    }
        
    private func addShadow() {
        equalsButtons?.layer.shadowColor = UIColor(hue: 351/360, saturation: 0.76, brightness: 0.97, alpha: 0.8).cgColor
        equalsButtons?.layer.shadowOpacity = 1
        equalsButtons?.layer.shadowRadius = 12
        equalsButtons?.layer.shadowOffset = CGSize(width: 0, height: 0)
        equalsButtons?.layer.masksToBounds = false
    }
}


