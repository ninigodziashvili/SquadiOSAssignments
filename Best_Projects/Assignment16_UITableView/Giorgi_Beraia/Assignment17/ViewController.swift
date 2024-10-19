//
//  ViewController.swift
//  Assignment17
//
//  Created by Giorgi on 17.10.24.
//

import UIKit

enum IsFav {
    case yes
    case no
}

struct Planet {
    var name: String
    var img: UIImage
    var area: String
    var temp: String
    var mass: String
    var fav: IsFav = .no
}

class ViewController: UIViewController, FavoritDelegate {
    var planetsArray: [Planet] = [
        Planet(name: "Mars", img: UIImage(named: "marsBig") ?? UIImage(), area: "1,258,250 km2", temp: "-18C", mass: "6,39E23 kg"),
        Planet(name: "Jupiter", img: UIImage(named: "jupiterBig") ?? UIImage(), area: "6,142E10 km2", temp: "-108C", mass: "1.898E27 kg"),
           Planet(name: "Earth", img: UIImage(named: "earthBig") ?? UIImage(), area: "500,100,100 km2", temp: "15C", mass: "5.972E24 kg"),
           Planet(name: "Saturn", img: UIImage(named: "saturnBig") ?? UIImage(), area: "2,608,250 km2", temp: "-139C", mass: "5.683E26 kg")
    ]
    var backgroundColorVC = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1)
    var textColor = UIColor(red: 179/255, green: 68/255, blue: 22/255, alpha: 1)
    let tableView = {
        var tableView = UITableView()
        tableView.register(PlanetCell.self, forCellReuseIdentifier: PlanetCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    let mainLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColorVC
        mainSetup()
        tableView.delegate = self
        tableView.dataSource = self
        applyGradient()
    }
    
    private func applyGradient() {
            let gradientLayer = CAGradientLayer()

            gradientLayer.colors = [
                UIColor(hue: 18/360, saturation: 0.89, brightness: 0.24, alpha: 1).cgColor,
                backgroundColorVC,
                UIColor(hue: 18/360, saturation: 0.89, brightness: 0.24, alpha: 1).cgColor
            ]
            gradientLayer.cornerRadius = 33
        gradientLayer.startPoint = CGPoint(x: 0.4, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.frame = view.bounds
            view.layer.insertSublayer(gradientLayer, at: 0)
           }
    
    private func mainSetup(){
        titleSetup()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "navBtnFliped"))
        navigationItem.backBarButtonItem?.tintColor = textColor
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
    private func titleSetup() {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel.text = "Planets"
        mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mainLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0).isActive = true
        mainLabel.textAlignment = .center
        mainLabel.textColor = textColor
        mainLabel.font = UIFont.boldSystemFont(ofSize: 48)
    }
    
    func moveCellToTop(from indexPath: IndexPath) {
        var itemToMove = planetsArray[indexPath.row]
        itemToMove.fav = .yes
        planetsArray.remove(at: indexPath.row)
        planetsArray.insert(itemToMove, at: 0)
        
        tableView.beginUpdates()
        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: indexPath.section))
        tableView.endUpdates()
    }
    
    func moveCellToBottom(from indexPath: IndexPath) {
        var itemToMove = planetsArray[indexPath.row]
        itemToMove.fav = .no
        planetsArray.remove(at: indexPath.row)
        planetsArray.append(itemToMove)
        
        tableView.beginUpdates()
        tableView.moveRow(at: indexPath, to: IndexPath(row: planetsArray.count - 1, section: indexPath.section))
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetCell.identifier, for: indexPath) as? PlanetCell else {
            fatalError("no cell code")
        }
        cell.cellSetup(planetsArray[indexPath.row])
        cell.parentViewController = self
        
        cell.delegate = self
        
        return cell
    }
    
    
}
protocol FavoritDelegate {
    var tableView: UITableView { get }
    func moveCellToTop(from indexPath: IndexPath)
    func moveCellToBottom(from indexPath: IndexPath)
}
#Preview {
    let vc = ViewController()
    return vc
}
