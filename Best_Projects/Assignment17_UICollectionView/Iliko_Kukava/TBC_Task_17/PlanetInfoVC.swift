//
//  PlanetInfoVC.swift
//  TBC_Task_17
//
//  Created by iliko on 10/21/24.
//

import UIKit

class PlanetInfoVC: UIViewController {
    
    // MARK: - Properties
    
    var planet: Planet?
    private let backButton = UIButton()
    private let configuration = UIImage.SymbolConfiguration(pointSize: 28)
    private let configurationOfStar = UIImage.SymbolConfiguration(pointSize: 25)
    var isSelected: Bool = false
    var onSelectionChanged: ((Planet, Bool) -> Void)?

    // MARK: - UI Elements
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 49)
        return titleLabel
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return button
    }()
    
    let planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let massLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        setupBackButton()
        configureCell()
        setupActionButton()
    }
    
    // MARK: - Setup Methods
    
    private func setupActionButton() {
        view.addSubview(actionButton)
        actionButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        actionButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        updateActionButton()

        actionButton.addAction(UIAction { [weak self] _ in
            self?.handleActionButtonTap()
        }, for: .touchUpInside)
    }
    
    private func handleActionButtonTap() {
        isSelected.toggle()
        updateActionButton()
        
        if let planet = planet {
            onSelectionChanged?(planet, isSelected)
        }
    }
    
    private func updateActionButton() {
        if isSelected {
            actionButton.tintColor = .systemYellow
        } else {
            actionButton.tintColor = .white
        }
    }
    
    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        var colors: [UIColor] = []
           
           if let planetName = planet?.name {
               switch planetName.lowercased() {
               case "earth":
                   colors = [
                       UIColor(hex: "3BAF3D", alpha: 1.0),
                       UIColor(hex: "A8D5BA", alpha: 0.7),
                       UIColor(hex: "E0F7FA", alpha: 0.2)
                   ]
               case "mars":
                   colors = [
                       UIColor(hex: "C85D2D", alpha: 1.0),
                       UIColor(hex: "F2B50D", alpha: 0.7),
                       UIColor(hex: "FFE0B2", alpha: 0.2)
                   ]
               case "jupiter":
                   colors = [
                       UIColor(hex: "C8A357", alpha: 1.0),
                       UIColor(hex: "BDA76B", alpha: 0.7),
                       UIColor(hex: "F4D03F", alpha: 0.2)
                   ]
               case "uranus":
                   colors = [
                    UIColor(hex: "C8A357", alpha: 1.0),
                    UIColor(hex: "BDA76B", alpha: 0.7),
                    UIColor(hex: "FFF5E1", alpha: 0.2)
                   ]
               case "neptune":
                   colors = [
                    UIColor(hex: "C8A357", alpha: 1.0),
                    UIColor(hex: "BDA76B", alpha: 0.7),
                    UIColor(hex: "FFF5E1", alpha: 0.2)
                   ]
               case "mercury":
                   colors = [
                    UIColor(hex: "B34416", alpha: 1.0),
                    UIColor(hex: "2D0B03", alpha: 0.7),
                    UIColor(hex: "B34416", alpha: 0.2)
                   ]
               default:
                   colors = [
                       UIColor(hex: "B34416", alpha: 1.0),
                       UIColor(hex: "2D0B03", alpha: 0.7),
                       UIColor(hex: "B34416", alpha: 0.2)
                   ]
               }
           }
        
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = [0.0, 0.8, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    private func setupBackButton() {
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: configuration), for: .normal)
        backButton.tintColor = UIColor(hex: "B34416", alpha: 1.0)
        backButton.addAction(UIAction(handler: { [weak self] action in self?.backFunc()}), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func backFunc() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureCell() {
        view.addSubview(titleLabel)
        view.addSubview(planetImageView)
        view.addSubview(areaLabel)
        view.addSubview(tempLabel)
        view.addSubview(massLabel)
        
        actionButton.setImage(UIImage(systemName: "star.fill", withConfiguration: configurationOfStar), for: .normal)

        titleLabel.text = "\(planet?.name ?? "No data")"
        planetImageView.image = UIImage(named: planet?.imageName ?? "")
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let areaValue = planet?.area {
            let formattedArea = formatter.string(from: NSNumber(value: areaValue)) ?? "0"
            areaLabel.text = "Area                        \(formattedArea) km²"
        } else {
            areaLabel.text = "Area: No data"
        }
        if let tempValue = planet?.temperature {
            let formattedArea = formatter.string(from: NSNumber(value: tempValue)) ?? "0"
            tempLabel.text = "Temperature                        \(formattedArea) ℃"
        } else {
            tempLabel.text = "Temperature: No data"
        }
        if let massValue = planet?.mass {
            let formattedArea = formatter.string(from: NSNumber(value: massValue)) ?? "0"
            massLabel.text = "Mass                        \(formattedArea) kg"
        } else {
            massLabel.text = "Mass: No data"
        }

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        planetImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        planetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planetImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        planetImageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        areaLabel.topAnchor.constraint(equalTo: planetImageView.bottomAnchor, constant: 30).isActive = true
        areaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        areaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        areaLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tempLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 20).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        massLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20).isActive = true
        massLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        massLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        massLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension UIViewController {
    func applyGradientBackground(colors: [UIColor], locations: [NSNumber]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
