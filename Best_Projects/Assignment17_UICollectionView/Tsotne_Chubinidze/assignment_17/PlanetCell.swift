//
//  PlanetCell.swift
//  assignment_17
//
//  Created by Cotne Chubinidze on 21.10.24.
//

import UIKit
protocol favouriteButtonDelegate: AnyObject {
    func favouriteButtonTapped(cell: PlanetCell?)
}
class PlanetCell: UICollectionViewCell {
    private var planet: Planet?
    private let nameLable = UILabel()
    private let favouriteButton = UIButton()
    private let imageView = UIImageView()
    private let areaLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        setupImageView()
        setupNameLable()
        setupAreaLable()
    }
    
    func configurePlanet(planet: Planet) {
        self.planet = planet
        imageView.image = planet.image
        nameLable.text = planet.name
        areaLable.text = "\(planet.area) km2"
        setupFavouritesButton()
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
    }
    
    private func setupNameLable() {
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLable)
        
        nameLable.font = UIFont(name: "OpenSans-Bold", size: 36)
        nameLable.textColor = .celltext
        nameLable.textAlignment = .left
        
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLable.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameLable.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupFavouritesButton() {
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favouriteButton)
        guard let planet else { return }
        let imageName = planet.isFavourite ? "Star1" : "Star"
        favouriteButton.setImage(UIImage(named: imageName), for: .normal)
        
        NSLayoutConstraint.activate([
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.heightAnchor.constraint(equalToConstant: 30),
            favouriteButton.centerYAnchor.constraint(equalTo: nameLable.centerYAnchor),
            favouriteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    
    @objc func favouriteButtonTapped() {
        delegate?.favouriteButtonTapped(cell: self)
    }
    
    private func setupAreaLable() {
        areaLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(areaLable)
        
        areaLable.font = UIFont(name: "OpenSans-Regular", size: 18)
        areaLable.textColor = .celltext
        areaLable.textAlignment = .left
        
        NSLayoutConstraint.activate([
            areaLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 8),
            areaLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            areaLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    var delegate: favouriteButtonDelegate?
}


