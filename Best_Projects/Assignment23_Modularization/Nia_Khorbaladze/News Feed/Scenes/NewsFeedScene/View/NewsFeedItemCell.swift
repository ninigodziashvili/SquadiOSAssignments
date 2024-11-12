//
//  NewsFeedItemCell.swift
//  News Feed
//
//  Created by Nkhorbaladze on 30.10.24.
//

import UIKit

final class NewsFeedItemCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    static let identifier = "NewsFeedCell"
    
    private lazy var uiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-SemiBold", size: 15)
        label.textColor = .white

        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-Regular", size: 15)
        label.textColor = .white

        return label
    }()
    
    private lazy var datePostedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-Regular", size: 15)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var authorAndDateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Setup
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        contentView.layer.cornerRadius = 10.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        contentView.addSubview(uiImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorAndDateView)
        authorAndDateView.addSubview(authorLabel)
        authorAndDateView.addSubview(datePostedLabel)
        contentView.addSubview(separator)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            uiImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            uiImageView.bottomAnchor.constraint(equalTo: separator.topAnchor),
            uiImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            uiImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            titleLabel.bottomAnchor.constraint(equalTo: authorAndDateView.topAnchor, constant: -45)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: authorAndDateView.leadingAnchor, constant: 8),
            authorLabel.bottomAnchor.constraint(equalTo: authorAndDateView.bottomAnchor),
            authorLabel.topAnchor.constraint(equalTo: authorAndDateView.topAnchor),
            datePostedLabel.trailingAnchor.constraint(equalTo: authorAndDateView.trailingAnchor, constant: -8),
            datePostedLabel.bottomAnchor.constraint(equalTo: authorAndDateView.bottomAnchor),
            datePostedLabel.topAnchor.constraint(equalTo: authorLabel.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            authorAndDateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            authorAndDateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            authorAndDateView.bottomAnchor.constraint(equalTo: separator.bottomAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: uiImageView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    // MARK: - Functions
    
    func configure(image: UIImage, title: String, author: String, date: String) {
        uiImageView.image = image
        titleLabel.text = title
        authorLabel.text = author
        datePostedLabel.text = date
    }
}
