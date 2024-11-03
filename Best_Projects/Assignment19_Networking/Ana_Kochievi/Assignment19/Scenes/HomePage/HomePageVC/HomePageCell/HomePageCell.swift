//
//  HomePageCell.swift
//  Assignment19
//
//  Created by MacBook on 30.10.24.
//

import UIKit
import Kingfisher

final class HomePageCell: UITableViewCell {
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor(hexString: "626262").withAlphaComponent(0.4).cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.frame = CGRect.zero
        gradient.cornerRadius = 10
        return gradient
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Bold", size: 12)
        label.textColor = UIColor(hexString: "FFFFFF")
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-SemiBold", size: 12)
        label.textColor = UIColor(hexString: "FFFFFF")
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-SemiBold", size: 12)
        label.textColor = UIColor(hexString: "FFFFFF")
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var publisherAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        
        return stackView
    }()
    
    static let identifier = "HomePageCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func setupCell() {
        contentView.addSubview(newsImageView)
        newsImageView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(newsLabel)
        contentView.addSubview(publisherAndDateStackView)
        
        setupCellConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = newsImageView.bounds
    }
    
    private func setupCellConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 8),
            newsLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -8),
            newsLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            publisherAndDateStackView.topAnchor.constraint(greaterThanOrEqualTo: newsLabel.bottomAnchor, constant: 8),
            publisherAndDateStackView.trailingAnchor.constraint(equalTo: newsLabel.trailingAnchor),
            publisherAndDateStackView.leadingAnchor.constraint(equalTo: newsLabel.leadingAnchor),
            publisherAndDateStackView.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -8)
        ])
    }
    
    public func configureCell(with data: Article) {
        newsLabel.text = data.title ?? "No Title Available"
        
        authorLabel.text = data.author ?? "Unknown Author"
        
        if let dateString = data.publishedAt, let date = ISO8601DateFormatter().date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = "No Date"
        }
        
        if let imageUrlString = data.urlToImage, let imageUrl = URL(string: imageUrlString) {
            newsImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder_image"))
        } else {
            newsImageView.image = UIImage(named: "placeholder_image")
        }
    }
}


