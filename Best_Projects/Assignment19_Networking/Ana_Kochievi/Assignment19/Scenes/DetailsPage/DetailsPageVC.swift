//
//  DetailsPageVC.swift
//  Assignment19
//
//  Created by MacBook on 30.10.24.
//

import UIKit
import Kingfisher

final class DetailsPageVC: UIViewController {
    
    var article: Article?
    
    private lazy var backArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addAction(UIAction(handler: { [ weak self ] action in
            self?.arrowBackButtonTapped()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var hotUpdatesLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Hot Updates"
        titleLabel.textColor = UIColor(hexString: "000000")
        titleLabel.font = UIFont(name: "AnekDevanagari-Bold", size: 17)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-SemiBold", size: 16)
        label.textColor = UIColor(hexString: "000000")
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Light", size: 12)
        label.textColor = UIColor(hexString: "000000")
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Regular", size: 14)
        label.textColor = UIColor(hexString: "000000")
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var publishedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Published by"
        label.textColor = UIColor(hexString: "2E0505")
        label.textAlignment = .left
        label.font = UIFont(name: "Nunito-Bold", size: 12)
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(hexString: "2E0505")
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "Nunito-Bold", size: 12)
        return label
    }()
    
    private lazy var publishingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publishedLabel, authorLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 14
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }
    
    private func setupNavigationBar() {
        title = "Hot Updates"
        navigationItem.backBarButtonItem?.isEnabled = false
        navigationItem.titleView = hotUpdatesLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backArrowButton)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(newsLabel)
        view.addSubview(dateLabel)
        view.addSubview(newsImageView)
        view.addSubview(newsDescriptionLabel)
        view.addSubview(publishingStackView)
        
        setupConstraints()
        configureUI()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            newsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            newsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: newsLabel.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: newsLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            newsImageView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            newsImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 144),
            newsImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 345)
        ])
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 7),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            publishingStackView.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 8),
            publishingStackView.trailingAnchor.constraint(equalTo: newsDescriptionLabel.trailingAnchor),
            publishingStackView.leadingAnchor.constraint(equalTo: newsDescriptionLabel.leadingAnchor)
        ])
    }
    
    private func arrowBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        newsLabel.text = article?.title ?? "No Title Available"
        
        if let publishedAtString = article?.publishedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: publishedAtString) {
                dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
                dateLabel.text = dateFormatter.string(from: date)
            } else {
                dateLabel.text = "No Date"
            }
        } else {
            dateLabel.text = "No Date"
        }
        
        newsDescriptionLabel.text = article?.description ?? "No Description Available"
        authorLabel.text = article?.author ?? "Unknown Author"
        
        if let imageUrlString = article?.urlToImage, let imageUrl = URL(string: imageUrlString) {
            newsImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder_image"))
        } else {
            newsImageView.image = UIImage(named: "placeholder_image")
        }
    }
}
