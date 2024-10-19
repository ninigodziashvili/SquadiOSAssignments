//
//  DetailsVC.swift
//  Planets
//
//  Created by Nkhorbaladze on 18.10.24.
//

import UIKit

class DetailsVC: UIViewController {
    
    // MARK: - Elements
    
    private let valueForArea = UILabel()
    private let valueForTemperature = UILabel()
    private let valueForMass = UILabel()
    
    var planetTitle: String?
    var planetImage: UIImage?
    var planetArea: String?
    var planetTemp: String?
    var planetMass: String?
    
    var planet: Planet?
    
    private let navigateBackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.isEnabled = true
        button.setImage(UIImage(named: "NavigateBack"), for: .normal)
        
        return button
    }()
    
    private let planetName: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 36)
        name.textColor = UIColor.init(named: "DetailsColor")
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return name
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        return imageView
    }()
    
    private let infoStackContainer: UIStackView = {
        let infoStackContainer = UIStackView()
        infoStackContainer.axis = .vertical
        infoStackContainer.spacing = 15
        infoStackContainer.translatesAutoresizingMaskIntoConstraints = false
        infoStackContainer.distribution = .fillEqually
        
        return infoStackContainer
    }()
    
    private lazy var infoContainerForArea: UIView = createInfoContainer()
    private lazy var infoContainerForTemperature: UIView = createInfoContainer()
    private lazy var infoContainerForMass: UIView = createInfoContainer()
    
    private lazy var areaLabel: UILabel = createLabel(text: "Area")
    private lazy var temperatureLabel: UILabel = createLabel(text: "Temperature")
    private lazy var massLabel: UILabel = createLabel(text: "Mass")
    
    private lazy var areaValue: UILabel = createValue(text: planetArea ?? "Couldn't find area")
    private lazy var temperatureValue: UILabel = createValue(text: planetTemp ?? "Couldn't find temperature")
    private lazy var massValue: UILabel = createValue(text: planetMass ?? "Couldn't find mass")
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "BackgroundColor")
        setup()
        
        planetName.text = planetTitle
        imageView.image = planetImage
        valueForArea.text = planetArea
    }
    
    private func setup() {
        setupBackButton()
        setupTitle()
        setupImageView()
        setupInfoStackContainer()
        setupInfoStacks()
        setValuesForTempAndMass()
    }
    
    private func setupTitle() {
        view.addSubview(planetName)
        
        planetName.textAlignment = .center
        planetName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        planetName.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        planetName.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        imageView.topAnchor.constraint(equalTo: planetName.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupInfoStackContainer() {
        view.addSubview(infoStackContainer)
        
        infoStackContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        infoStackContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        infoStackContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        infoStackContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        infoStackContainer.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        infoStackContainer.addArrangedSubview(infoContainerForArea)
        infoStackContainer.addArrangedSubview(infoContainerForTemperature)
        infoStackContainer.addArrangedSubview(infoContainerForMass)
    }
    
    private func setupInfoStacks() {
        infoContainerForArea.addSubview(areaLabel)
        infoContainerForTemperature.addSubview(temperatureLabel)
        infoContainerForMass.addSubview(massLabel)
        
        infoContainerForArea.addSubview(areaValue)
        infoContainerForTemperature.addSubview(temperatureValue)
        infoContainerForMass.addSubview(massValue)
        
        infoContainerForArea.heightAnchor.constraint(equalToConstant: 50).isActive = true
        infoContainerForTemperature.heightAnchor.constraint(equalToConstant: 50).isActive = true
        infoContainerForMass.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        areaLabel.leftAnchor.constraint(equalTo: infoContainerForArea.leftAnchor, constant: 12).isActive = true
        areaLabel.centerYAnchor.constraint(equalTo: infoContainerForArea.centerYAnchor).isActive = true
        areaValue.rightAnchor.constraint(equalTo: infoContainerForArea.rightAnchor, constant: -12).isActive = true
        areaValue.centerYAnchor.constraint(equalTo: infoContainerForArea.centerYAnchor).isActive = true
        
        temperatureLabel.leftAnchor.constraint(equalTo: infoContainerForTemperature.leftAnchor, constant: 12).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: infoContainerForTemperature.centerYAnchor).isActive = true
        temperatureValue.rightAnchor.constraint(equalTo: infoContainerForTemperature.rightAnchor, constant: -12).isActive = true
        temperatureValue.centerYAnchor.constraint(equalTo: infoContainerForTemperature.centerYAnchor).isActive = true
        
        massLabel.leftAnchor.constraint(equalTo: infoContainerForMass.leftAnchor, constant: 12).isActive = true
        massLabel.centerYAnchor.constraint(equalTo: infoContainerForMass.centerYAnchor).isActive = true
        massValue.rightAnchor.constraint(equalTo: infoContainerForMass.rightAnchor, constant: -12).isActive = true
        massValue.centerYAnchor.constraint(equalTo: infoContainerForMass.centerYAnchor).isActive = true
    }
    
    private func setValuesForTempAndMass() {
        if let planet = planet {
            temperatureValue.text = planet.getTemperature()
        }
        if let planet = planet {
            massValue.text = planet.getMass()
        }
    }
    
    private func setupBackButton() {
        navigateBackButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateBack()
        }), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigateBackButton)
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions to reuse
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func createValue(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func createInfoContainer() -> UIView {
        let info = UIView()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.layer.borderWidth = 1.5
        info.layer.borderColor = UIColor.white.cgColor
        info.layer.cornerRadius = 10
        info.layer.masksToBounds = true
        
        return info
    }
}
