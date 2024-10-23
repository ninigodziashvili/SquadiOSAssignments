//
//  PlanetCell.swift
//  TBC_Task_17
//
//  Created by iliko on 10/20/24.
//

import UIKit

protocol PlanetCellDelegate: AnyObject {
    func addTapped(cell: PlanetCell)
}

class PlanetCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    private let configurationOfStar = UIImage.SymbolConfiguration(pointSize: 15)

    private let planetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Delegate
    
    weak var delegate: PlanetCellDelegate?
    
    // MARK: - Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.awakeFromNib()
        
        contentView.addSubview(planetLabel)
        contentView.addSubview(areaLabel)
        contentView.addSubview(actionButton)
        contentView.addSubview(planetImageView)
        
        actionButton.setImage(UIImage(systemName: "star.fill", withConfiguration: configurationOfStar), for: .normal)
        
        planetImageView.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -50).isActive = true
        planetImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40).isActive = true
        
        planetLabel.topAnchor.constraint(equalTo: planetImageView.bottomAnchor, constant: 10).isActive = true
        planetLabel.centerXAnchor.constraint(equalTo: planetImageView.centerXAnchor).isActive = true
        
        actionButton.leftAnchor.constraint(equalTo: planetLabel.rightAnchor, constant: 5).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: planetLabel.centerYAnchor).isActive = true
        
        areaLabel.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 5).isActive = true
        areaLabel.centerXAnchor.constraint(equalTo: planetLabel.centerXAnchor).isActive = true
        
        actionButton.addAction(UIAction { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.addTapped(cell: strongSelf)
        }, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateUI(with planet: Planet) {
        planetLabel.text = planet.name
    }
}
