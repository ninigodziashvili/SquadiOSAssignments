//
//  NewsDetailsViewController.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import UIKit
import Network
import DateFormater

class NewsDetailViewController: UIViewController {
    var article: NewsArticle
    var dateformatter: DateFormatterProtocol
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let articleImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let authorLabel = UILabel()
    private let backButton = UIButton()
    private let viewTitleLabel = UILabel()
    
    init(article: NewsArticle, dateformatter: DateFormatterProtocol) {
        self.article = article
        self.dateformatter = dateformatter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        setupViews()
        configureViews()
    }
    
    private func setupViews() {
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        
        viewTitleLabel.text = "Hot Updates"
        viewTitleLabel.font = UIFont.boldSystemFont(ofSize: .init(15))
        viewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTitleLabel)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            backButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewTitleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)

        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleImageView)

        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            articleImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            articleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),

            descriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureViews() {
        titleLabel.text = article.title
        dateLabel.text = dateformatter.formatDate(article.publishedAt)
        descriptionLabel.text = article.description
        authorLabel.text = "By \(article.author ?? "Unknown")"

        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            articleImageView.image = UIImage(named: "placeholder")
        }
    }
}
