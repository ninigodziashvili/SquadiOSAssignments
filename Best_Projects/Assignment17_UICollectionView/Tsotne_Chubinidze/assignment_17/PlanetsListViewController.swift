//
//  ViewController.swift
//  assignment_17
//
//  Created by Cotne Chubinidze on 19.10.24.
//

import UIKit
class PlanetsListViewController: UIViewController {
    private let nameLabel = UILabel()
    private var planets: [Planet] = []
    private let planetsCollectionView: UICollectionView = {
        let collection: UICollectionView
        let collectionlayout = UICollectionViewFlowLayout()
        collectionlayout.scrollDirection = .vertical
        collectionlayout.itemSize = CGSize(width: 180, height: 230)
        collectionlayout.minimumLineSpacing = 0
        collectionlayout.minimumInteritemSpacing = 0
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionlayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        initialisePlanets()
        setupPlanetsListViewController()
        setupLabel()
    }
    
    private func setupLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.text = "Planets"
        nameLabel.textColor = .celltext
        nameLabel.font = UIFont(name: "OpenSans-Bold", size: 36)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func initialisePlanets() {
        planets = [
            Planet(name: "Mercury",
                   area: "74800000",
                   mass: "3.285e23",
                   temperature: "167",
                   image: UIImage(named: "mercury") ?? UIImage()),
            
            Planet(name: "Venus",
                   area: "460200000",
                   mass: "4.867e24",
                   temperature: "464",
                   image: UIImage(named: "venus") ?? UIImage()),
            
            Planet(name: "Earth",
                   area: "510100100",
                   mass: "5.972e24",
                   temperature: "15",
                   image: UIImage(named: "earth") ?? UIImage()),
            
            Planet(name: "Mars",
                   area: "144400000",
                   mass: "6.39e23",
                   temperature: "-63",
                   image: UIImage(named: "mars") ?? UIImage()),
            
            Planet(name: "Jupiter",
                   area: "6142e10",
                   mass: "1.898e27",
                   temperature: "-108",
                   image: UIImage(named: "jupiter") ?? UIImage()),
            
            Planet(name: "Uranus",
                   area: "8083e9",
                   mass: "8.681e25",
                   temperature: "-197",
                   image: UIImage(named: "uranus") ?? UIImage())
        ]
    }
    
    private func setupPlanetsListViewController() {
        view.addSubview(planetsCollectionView)
        
        NSLayoutConstraint.activate([
            planetsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            planetsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            planetsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            planetsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        planetsCollectionView.register(PlanetCell.self, forCellWithReuseIdentifier: "PlanetCell")
        planetsCollectionView.dataSource = self
        planetsCollectionView.delegate = self
    }
}

extension PlanetsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentPlanet = planets[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as! PlanetCell
        cell.configurePlanet(planet: currentPlanet)
        cell.delegate = self
        return cell
    }
}

extension PlanetsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let planet = planets[indexPath.row]
        
        let vc = PlanetInfoViewController(planet: planet)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PlanetsListViewController: favouriteButtonDelegate {
    func favouriteButtonTapped(cell: PlanetCell?) {
        guard let cell else { return }
        let selectedIndex = planetsCollectionView.indexPath(for: cell)
        planets[selectedIndex!.row].isFavourite.toggle()
        planets.sort { $0.isFavourite && !$1.isFavourite }
        planetsCollectionView.reloadData()
    }
}

extension PlanetsListViewController: reloadDataDelegate {
    func reloadData() {
        planets.sort { $0.isFavourite && !$1.isFavourite }
        self.planetsCollectionView.reloadData()
    }
}

