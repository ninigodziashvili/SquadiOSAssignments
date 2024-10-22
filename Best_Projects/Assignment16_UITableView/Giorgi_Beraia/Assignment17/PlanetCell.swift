//
//  PlanetCell.swift
//  Assignment17
//
//  Created by Giorgi on 18.10.24.
//

import UIKit

class PlanetCell: UITableViewCell {
    var delegate: FavoritDelegate?
    var moveCellAction: (() -> Void)?
    var moveCellDownAction: (() -> Void)?
    weak var parentViewController: UIViewController?
    static let identifier = "PlanetCell"
    private let stack = UIStackView()
    private let textStack =  UIStackView()
    private let title = UILabel()
    private var planetObject: Planet? = nil
    
    private let myImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "mars")
        return img
    }()
    
    private let navButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "navBtn"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 36).isActive = true
        return btn
    }()
    
    private let favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.tintColor = ViewController().textColor
        btn.widthAnchor.constraint(equalToConstant: 36).isActive = true
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        navButton.addAction(UIAction(handler: { [weak self] action  in
                    self?.nextPage()
                }), for: .touchUpInside)
        favButton.addAction(UIAction(handler: { [weak self] action  in
            self?.favoriteMaker()
                }), for: .touchUpInside)
    }
    
    func cellSetup(_ planet: Planet){
        planetObject = planet
        backgroundColor = .clear
        stackSetup()
        myImage.image = planet.img
        textStackSetup(planet.name, planet.area)
        stack.addArrangedSubview(myImage)
        stack.addArrangedSubview(textStack)
        stack.addArrangedSubview(favButton)
        stack.addArrangedSubview(navButton)
        myImage.translatesAutoresizingMaskIntoConstraints = false
        navButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImage.heightAnchor.constraint(equalToConstant: 100),
            myImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        navButton.addAction(UIAction(handler: { [weak self] action  in
                    self?.nextPage()
                }), for: .touchUpInside)
        
        favButton.addAction(UIAction(handler: { [weak self] action  in
            self?.favoriteMaker()
                }), for: .touchUpInside)
    }
    
    private func stackSetup() {
        stack.axis = .horizontal
        stack.spacing = 11
        stack.alignment = .center
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            stack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            stack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func textStackSetup(_ planetName: String, _ descriptionText: String) {
        textStack.axis = .vertical
        textStack.translatesAutoresizingMaskIntoConstraints = false

            
        let bigTitleLabel = UILabel()
        bigTitleLabel.text = planetName
        bigTitleLabel.font = UIFont.boldSystemFont(ofSize: 49)
        bigTitleLabel.textColor = .white
        bigTitleLabel.textAlignment = .left
        bigTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let smallTitleLabel = UILabel()
        smallTitleLabel.text = descriptionText
        smallTitleLabel.font = UIFont.systemFont(ofSize: 24)
        smallTitleLabel.textColor = .white
        smallTitleLabel.textAlignment = .left
        smallTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        textStack.addArrangedSubview(bigTitleLabel)
        textStack.addArrangedSubview(smallTitleLabel)
    }
    
    func nextPage(){
        let vc = InfoController()
        vc.mainSetup(planetObject!)
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func favoriteMaker() {
        guard let indexPathNew = self.delegate?.tableView.indexPath(for: self) else { return }
        if  planetObject?.fav == .no {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            self.delegate?.moveCellToTop(from: indexPathNew )
            planetObject?.fav = .yes
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            self.delegate?.moveCellToBottom(from: indexPathNew)
            planetObject?.fav = .no
        }
    }
}

#Preview {
    let vc = ViewController()
    return vc
}
