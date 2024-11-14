//
//  NewsArticleCell.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import UIKit
import Network

class NewsArticleCell: UITableViewCell {
    static let identifier = "NewsArticleCell"

    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let articleImageView = UIImageView()

    var imageHeight: CGFloat = 120 {
        didSet {
            articleImageViewHeightConstraint.constant = imageHeight
        }
    }

    private var articleImageViewHeightConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImageView)

        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        authorLabel.textColor = .white
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)

        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)

        articleImageViewHeightConstraint = articleImageView.heightAnchor.constraint(equalToConstant: imageHeight)

        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articleImageViewHeightConstraint,

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),

            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }

    func configure(with article: NewsArticle) {
        titleLabel.text = article.title
        authorLabel.text = "By \(article.author ?? "Unknown")"
        dateLabel.text = formatDate(article.publishedAt)

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

    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = dateFormatter.date(from: dateString) else { return dateString }

        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
