//
//  DetailsView.swift
//  News Feed
//
//  Created by Nkhorbaladze on 30.10.24.
//

import UIKit

final class DetailsView: UIViewController {
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-SemiBold", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var datePostedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-ExtraLight", size: 13)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var uiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var descriptionTextView: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Nunito-Regular", size: 15)
        text.textColor = .black
        text.numberOfLines = 0
        
        return text
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-SemiBold", size: 15)
        label.textColor = .black
        
        return label
    }()
    
    private let navigateBackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.isEnabled = true
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var navigationBarTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Nunito-ExtraBold", size: 18)
        label.text = "Hot Updates"
        
        return label
    }()
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    private func setup() {
        setupUI()
        setupConstraints()
        setupBackButton()
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(datePostedLabel)
        containerView.addSubview(uiImageView)
        containerView.addSubview(descriptionTextView)
        containerView.addSubview(authorLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            datePostedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            datePostedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            datePostedLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            uiImageView.topAnchor.constraint(equalTo: datePostedLabel.bottomAnchor, constant: 12),
            uiImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            uiImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            uiImageView.heightAnchor.constraint(equalToConstant: 145)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: uiImageView.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupBackButton() {
        navigateBackButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateBack()
        }), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigateBackButton)
        navigationItem.titleView = navigationBarTitle
        
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureDetails(title: String, date: String, image: UIImage, description: String, author: String) {
        titleLabel.text = title
        datePostedLabel.text = date
        uiImageView.image = image
        descriptionTextView.text = description
        authorLabel.text = author
    }
}
