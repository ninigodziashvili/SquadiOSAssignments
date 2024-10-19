//
//  CustomCell.swift
//  Planets
//
//  Created by Nkhorbaladze on 18.10.24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // MARK: - Elements
    
    static let identifier = "CustomCell"
    let detailsVC = DetailsVC()
    
    var navigateToDetails: (() -> Void)?
    
    private let imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return imageV
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 36)
        nameLabel.textColor = .white
        
        return nameLabel
    }()
    
    private let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.font = UIFont.systemFont(ofSize: 18)
        distanceLabel.textColor = .white
        
        return distanceLabel
    }()
    
    private let labelsStack: UIStackView = {
        let labelsStack = UIStackView()
        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        return labelsStack
    }()
    
    private let navigateToDetailsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.isEnabled = true
        button.setImage(UIImage(named: "NavigateToDetails"), for: .normal)
        
        return button
    }()
    
    private let separatorView: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .clear
        
        return separator
    }()
    
    // MARK: - Functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        navigate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func navigate() {
        navigateToDetailsButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateToDetails?() // Call the closure when the button is tapped
        }), for: .touchUpInside)
    }
    
    private func configureCell() {
        contentView.addSubview(imageV)
        contentView.addSubview(labelsStack)
        contentView.addSubview(navigateToDetailsButton)
        
        labelsStack.addArrangedSubview(nameLabel)
        labelsStack.addArrangedSubview(distanceLabel)
        
        imageV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        labelsStack.topAnchor.constraint(equalTo: imageV.topAnchor).isActive = true
        labelsStack.leadingAnchor.constraint(equalTo: imageV.trailingAnchor, constant: 36).isActive = true
        
        navigateToDetailsButton.centerYAnchor.constraint(equalTo: imageV.centerYAnchor).isActive = true
        navigateToDetailsButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -13).isActive = true
        navigateToDetailsButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        navigateToDetailsButton.widthAnchor.constraint(equalTo: navigateToDetailsButton.heightAnchor).isActive = true
    }
    
    func customizeCell(image: UIImage, name: String, distance: String) {
        imageV.image = image
        nameLabel.text = name
        distanceLabel.text = distance
    }
}
