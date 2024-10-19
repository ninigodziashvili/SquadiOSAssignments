//
//  InfoController.swift
//  Assignment17
//
//  Created by Giorgi on 18.10.24.
//

import UIKit

class InfoController: UIViewController {
    var delegate: FavoritDelegate?
    private let infoStack = UIStackView()
    let mainLabel = UILabel()
    let planetImage = UIImageView()
    var backgroundColorIC = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1)
    var textColor = UIColor(red: 179/255, green: 68/255, blue: 22/255, alpha: 1)
    let favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.tintColor = ViewController().textColor
        btn.widthAnchor.constraint(equalToConstant: 36).isActive = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColorIC
        infoStackSetup()
    }
    func mainSetup(_ planet: Planet){
        mainLabelSetup(planet.name)
        if  planet.fav == .yes {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        imageSetup(planet.img)
        lineSetup("Area", planet.area)
        lineSetup("Temperature", planet.temp)
        lineSetup("Mass", planet.mass)
        favButtonSetup()
    }
    
    private func favButtonSetup() {
        view.addSubview(favButton)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favButton.bottomAnchor.constraint(equalTo: planetImage.topAnchor, constant: 20)
        ])
    }
    
    private func imageSetup(_ image: UIImage) {
        planetImage.image = image
        planetImage.contentMode = .scaleAspectFit
        view.addSubview(planetImage)
        planetImage.translatesAutoresizingMaskIntoConstraints = false
        
        var imageSize: CGFloat = 1/3
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight <= 667 {
            imageSize = 1/4
        }
        NSLayoutConstraint.activate([
            planetImage.bottomAnchor.constraint(equalTo: infoStack.topAnchor, constant: -72),
            planetImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            planetImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            planetImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: imageSize)
        ])
    }
    
    private func mainLabelSetup(_ text: String) {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel.text = text
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0)
        ])
        mainLabel.textAlignment = .center
        mainLabel.textColor = textColor
        mainLabel.font = UIFont.boldSystemFont(ofSize: 48)
    }
    
    private func infoStackSetup() {
        view.addSubview(infoStack)
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .vertical
        infoStack.spacing = 15.5
        infoStack.distribution = .fillEqually
        NSLayoutConstraint.activate([
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -63),
            infoStack.heightAnchor.constraint(equalToConstant: 225)
        ])
    }
    
    private func lineStackSetup() -> UIStackView {
        let lineStack = UIStackView()
        view.addSubview(lineStack)
        lineStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.addArrangedSubview(lineStack)
        lineStack.layer.borderWidth = 1
        lineStack.layer.borderColor = UIColor.white.cgColor
        lineStack.layer.cornerRadius = 15
        lineStack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        lineStack.isLayoutMarginsRelativeArrangement = true
        lineStack.axis = .horizontal
        lineStack.distribution = .equalSpacing
        
        return lineStack
    }
    
    private func lineSetup(_ title: String, _ text: String){
        let lineStack = lineStackSetup()
        let lineTitle = titleSetup(title)
        let lineText = textSetup(text)
        lineStack.addArrangedSubview(lineTitle)
        lineStack.addArrangedSubview(lineText)
    }
    
    private func titleSetup(_ givenText: String) -> UILabel{
        let title = UILabel()
        view.addSubview(title)
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 24.51)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = givenText
        return title
    }
    
    private func textSetup(_ givenText: String) -> UILabel {
        let text = UILabel()
        view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 24.51)
        text.text = givenText
        return text
    }
}

#Preview {
    let vc = InfoController()
    return vc
}
