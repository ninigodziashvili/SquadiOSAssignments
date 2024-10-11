//
//  ViewController.swift
//  TBC-Calculator
//
//  Created by irakli kharshiladze on 09.10.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numbersView: UIView!
    @IBOutlet weak var themSwitchBtn: UIButton!
    @IBOutlet weak var equalBtn: UIButton!

    
    var isDark: Bool = false
    private let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyGradient()
        viewWillLayoutSubviews()
    }
    
    @IBAction func changeTheme() {
        isDark.toggle()
        themSwitchBtn.setImage(UIImage(systemName: isDark ? "sun.min" : "moon"), for: .normal)
              view.overrideUserInterfaceStyle = isDark ? .dark : .light
    }
    
    func setupUI() {
        numbersView.layer.cornerRadius = 30
    }

    private func applyGradient() {
        let colorOne = UIColor(red: 237/255, green: 14/255, blue: 152/255, alpha: 1.0)
        let colorTwo = UIColor(red: 254/255, green: 90/255, blue: 46/255, alpha: 1.0)
        
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.cornerRadius = 30
        equalBtn.layer.insertSublayer(gradient, at: 0)
        equalBtn.layer.cornerRadius = 30
        updateGradientFrame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }

    private func updateGradientFrame() {
        gradient.frame = equalBtn.bounds
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.updateGradientFrame()
        }, completion: nil)
    }
}

