//
//  ViewController.swift
//  TBC_Task_17
//
//  Created by iliko on 10/19/24.
//

import UIKit

class PlanetsVC: UIViewController {
    
    // MARK: = UI Elements
    
    let planetsCollectionView: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: 180, height: 200)
        collection = UICollectionView(frame: CGRect(x: 20, y: 20, width: 100, height: 100), collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    let sectionTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Planets"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 49)
        return title
    }()
    
    // MARK: - Data
    
    private var planets: [Planet] = [
        Planet(name: "Mercury", area: 74000000, temperature: 430, mass: 43923, imageName: "mercury"),
        Planet(name: "Venus", area: 460000000, temperature: 471, mass: 73923, imageName: "venus"),
        Planet(name: "Earth", area: 510100100, temperature: 15, mass: 63923, imageName: "earth"),
        Planet(name: "Mars", area: 12582500, temperature: -65, mass: 53923, imageName: "mars"),
        Planet(name: "Jupiter", area: 50010010000, temperature: -110, mass: 193923, imageName: "jupiter"),
        Planet(name: "Uranus", area: 25765890, temperature: -195, mass: 63923, imageName: "uranus"),
    ]
    
    private var selectedPlanets: [Planet] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.addSubview(sectionTitle)
        applyGradientBackground()
        setupCollectionView()
        
        sectionTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        sectionTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
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
    
    private func setupCollectionView() {
        view.addSubview(planetsCollectionView)
        
        planetsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        planetsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        planetsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        planetsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        planetsCollectionView.dataSource = self
        planetsCollectionView.delegate = self
        planetsCollectionView.register(PlanetCell.self, forCellWithReuseIdentifier: "PlanetCell")
        planetsCollectionView.backgroundColor = .clear
    }
    
    // MARK: - helper methods
    
    private func toggleSelection(for planet: Planet) {
        if let index = selectedPlanets.firstIndex(where: { $0.name == planet.name }) {
            selectedPlanets.remove(at: index)
        } else {
            selectedPlanets.insert(planet, at: 0)
        }
        updatePlanetsOrder()
    }
    
    private func updatePlanetsOrder() {
        planets = selectedPlanets + planets.filter { planet in
            !selectedPlanets.contains(where: { $0.name == planet.name })
        }
        planetsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension PlanetsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlanet = planets[indexPath.row]
        
        let vc = PlanetInfoVC()
        
        vc.planet = selectedPlanet
        vc.isSelected = selectedPlanets.contains(where: { $0.name == selectedPlanet.name })
        
        vc.onSelectionChanged = { [weak self] planet, isSelected in
            if isSelected {
                self?.selectedPlanets.insert(planet, at: 0)
            } else {
                self?.selectedPlanets.removeAll { $0.name == planet.name }
            }
            self?.updatePlanetsOrder()
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: - UICollectionViewDataSource

extension PlanetsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as! PlanetCell
        cell.backgroundColor = .clear
        let currentPlanet = planets[indexPath.row]
        
        if selectedPlanets.contains(where: { $0.name == currentPlanet.name }) {
            cell.actionButton.tintColor = .systemYellow
        } else {
            cell.actionButton.tintColor = .white
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedArea = formatter.string(from: NSNumber(value: currentPlanet.area)) {
            cell.areaLabel.text = "\(formattedArea) km²"
        }
        cell.areaLabel.textColor = .white
        cell.planetImageView.image = UIImage(named: currentPlanet.imageName)
        
        cell.updateUI(with: currentPlanet)
        cell.delegate = self
        return cell
    }
}

// MARK: - PlanetCellDelegate

extension PlanetsVC: PlanetCellDelegate {
    func addTapped(cell: PlanetCell) {
        if let indexPath = planetsCollectionView.indexPath(for: cell) {
            let planet = planets[indexPath.row]
            toggleSelection(for: planet)
        }
    }
}

// MARK: - UIColor Extension

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



































//
//
//import SwiftUI
//
//struct ViewControllerPreview: UIViewControllerRepresentable {
//    
//    func makeUIViewController(context: Context) -> PlanetsVC {
//        return PlanetsVC()
//    }
//    
//    func updateUIViewController(_ uiViewController: PlanetsVC, context: Context) {
//    }
//}
//
//struct ViewPreview: PreviewProvider {
//    static var previews: some View {
//        ViewControllerPreview()
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//
//#Preview {
//    ViewControllerPreview()
//}

