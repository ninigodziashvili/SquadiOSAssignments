//
//  PlanetsListVC.swift
//  Planets
//
//  Created by Nkhorbaladze on 18.10.24.
//

import UIKit

class PlanetsListVC: UIViewController {

    // MARK: - elements
    private let imageNames = ["Mars", "Jupiter", "Earth", "Saturn", "Neptune", "Uranus", "Venus", "Mercury"]
    private let areas = ["1,258,250 km2", "6,142E10 km2", "500,100,100 km2", "2,608,250 km2", "76,800,000 km2", "81,300,000 km2", "460,200,000 km2", "75,200,000 km2"]
    
    private var imagesWithTitles: [(image: UIImage, title: String, distance: String)] = []
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(named: "DetailsColor")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        
        return titleLabel
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.init(named: "BackgroundColor")
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
            
        return tableView
    }()
    
    // MARK: - SETUP & Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "BackgroundColor")
        setup()
    }
    
    private func setup() {
        setupTitle()
        setupTableView()
        appendValues()
    }
    
    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.text = "Planets"
        
        titleLabel.textAlignment = .center
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func appendValues() {
        for (index, imageName) in imageNames.enumerated() {
            if let image = UIImage(named: imageName) {
                let distance = areas[index]
                imagesWithTitles.append((image: image, title: imageName, distance: distance))
            }
        }
    }
}

    // MARK: - EXTENSIONS

extension PlanetsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesWithTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        let imageWithTitle = imagesWithTitles[indexPath.row]
        let image = imageWithTitle.image
        let title = imageWithTitle.title
        let distance = imageWithTitle.distance
        
        cell.customizeCell(image: image, name: title, distance: distance)
        cell.backgroundColor = UIColor.init(named: "BackgroundColor")
        
        cell.navigateToDetails = { [weak self] in
            let detailsvc = DetailsVC()
            self?.navigationController?.pushViewController(detailsvc, animated: true)
        }

        return cell
    }
}

extension PlanetsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPlanet = imagesWithTitles[indexPath.row]
        let detailsvc = DetailsVC()
        
        detailsvc.planetTitle = selectedPlanet.title
        detailsvc.planetImage = selectedPlanet.image
        detailsvc.planetArea = selectedPlanet.distance
        
        if let planetEnum = Planet.planetName(rawValue: selectedPlanet.title) {
            let planet = Planet(name: planetEnum)
            
            detailsvc.planet = planet
            navigationController?.pushViewController(detailsvc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
