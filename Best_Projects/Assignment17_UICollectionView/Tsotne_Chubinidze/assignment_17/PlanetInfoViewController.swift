//
//  PlanetInfoViewController.swift
//  assignment_17
//
//  Created by Cotne Chubinidze on 21.10.24.
//

import UIKit
protocol reloadDataDelegate: AnyObject {
    func reloadData()
}
class PlanetInfoViewController: UIViewController {
    private let backButton = UIButton()
    private let favouritesButton = UIButton()
    private let planetImageView = UIImageView()
    private let titleName = UILabel()
    private let massLable = UILabel()
    private let areaLable = UILabel()
    private let temperatureLable = UILabel()
    
    private var planet: Planet?
    weak var delegate: reloadDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(planet: Planet) {
        super.init(nibName: nil, bundle: nil)
        self.planet = planet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        setupTitleLabel()
        setupBackButton()
        setupInfoLabels()
        setupFavouritesButton()
        setupPlanetImage()
    }
    
    private func setupTitleLabel() {
        titleName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleName)
        
        titleName.text = planet?.name
        titleName.textColor = .celltext
        titleName.font = UIFont(name: "OpenSans-Bold", size: 36)
        
        NSLayoutConstraint.activate([
            titleName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(named: "navigate_before"), for: .normal)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
        
        backButton.addTarget(self, action: #selector (backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupLable(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupInfoLabels() {
        if let planet = planet {
            setupLable(label: massLable)
            view.addSubview(massLable)
            massLable.text        = "   Mass:                   \(planet.mass)"
            
            setupLable(label: temperatureLable)
            view.addSubview(temperatureLable)
            temperatureLable.text = "   Temperature:            \(planet.temperature)"
            
            setupLable(label: areaLable)
            view.addSubview(areaLable)
            areaLable.text        = "   Area:                   \(planet.area)"
        }
        
        
        NSLayoutConstraint.activate([
            
            massLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            massLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            massLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            massLable.heightAnchor.constraint(equalToConstant: 52),
            
            temperatureLable.bottomAnchor.constraint(equalTo: massLable.topAnchor, constant: -12),
            temperatureLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            temperatureLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            temperatureLable.heightAnchor.constraint(equalToConstant: 52),
            
            areaLable.bottomAnchor.constraint(equalTo: temperatureLable.topAnchor, constant: -12),
            areaLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            areaLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            areaLable.heightAnchor.constraint(equalToConstant: 52),
            
        ])
    }
    
    private func setupPlanetImage() {
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        planetImageView.image = planet?.image
        view.addSubview(planetImageView)
        
        NSLayoutConstraint.activate([
            planetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            planetImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            planetImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            planetImageView.heightAnchor.constraint(equalTo: planetImageView.widthAnchor, multiplier: 1)
        ])
        
        planetImageView.layer.cornerRadius = planetImageView.bounds.width / 2
        planetImageView.clipsToBounds = true
        
    }
    
    private func setupFavouritesButton() {
        favouritesButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favouritesButton)
        favouritesButton.setTitle("", for: .normal)
        
        guard let planet else { return }
        let imageName = planet.isFavourite ? "Star1" : "Star"
        favouritesButton.setImage(UIImage(named: imageName), for: .normal)
        favouritesButton.imageView?.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            favouritesButton.heightAnchor.constraint(equalToConstant: 25),
            favouritesButton.widthAnchor.constraint(equalToConstant: 25),
            favouritesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            favouritesButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        
        favouritesButton.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favouritesButtonTapped() {
        guard let planet else { return }
        planet.isFavourite.toggle()
        let imageName = planet.isFavourite ? "Star1" : "Star"
        favouritesButton.setImage(UIImage(named: imageName), for: .normal)
        delegate?.reloadData()
    }
}
