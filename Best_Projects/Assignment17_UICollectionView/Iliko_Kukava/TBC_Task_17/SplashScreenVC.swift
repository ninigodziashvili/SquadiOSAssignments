//
//  SplashScreenVC.swift
//  TBC_Task_17
//
//  Created by iliko on 10/21/24.
//

import UIKit

class SplashScreenVC: UIViewController {
    
    // MARK: - UI Elements
    
    let splashLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Solar System"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "B34416", alpha: 1.0).cgColor,
            UIColor(hex: "2D0B03", alpha: 0.2).cgColor,
            UIColor(hex: "B34416", alpha: 0.2).cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI() {
        view.addSubview(splashLabel)
        
        splashLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        splashLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let planetsVC = PlanetsVC()
            let navigationController = UINavigationController(rootViewController: planetsVC)
            
            self.view.window?.rootViewController = navigationController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
