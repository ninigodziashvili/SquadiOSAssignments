//
//  NewsListTableViewCell.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

import UIKit
import DateFormatterUtility

class NewsListTableViewCell: UITableViewCell {
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Bold", size: 18) ?? UIFont.boldSystemFont(ofSize: 18), textColor: .white, alignment: .left, numberOfLines: 0)
        
        return label
    }()
    
    private let authorAndDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let newsAuthor: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Regular", size: 16) ?? UIFont.boldSystemFont(ofSize: 16), textColor: .white, alignment: .left)
        
        return label
    }()
    
    private let newsPublishDate: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Regular", size: 16) ?? UIFont.boldSystemFont(ofSize: 16), textColor: .white, alignment: .right)
        
        return label
    }()
    
    private let newsListViewModel = NewsListViewModel()
    
    private let gradient = LinearGradient()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupNewsImageView()
        setupGradient()
        setupNewsTitle()
        setupAuthorAndDateStackView()
        
    }
    
    private func setupNewsImageView() {
        contentView.addSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupGradient() {
        newsImageView.insertSubview(gradient, at: 0)
        gradient.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: newsImageView.topAnchor),
            gradient.leftAnchor.constraint(equalTo: newsImageView.leftAnchor),
            gradient.rightAnchor.constraint(equalTo: newsImageView.rightAnchor),
            gradient.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor)

        ])
    }
    
    private func setupNewsTitle() {
        newsImageView.addSubview(newsTitle)
        
        NSLayoutConstraint.activate([
            newsTitle.leftAnchor.constraint(equalTo: newsImageView.leftAnchor, constant: 8),
            newsTitle.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 8),
            newsTitle.rightAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: -8)
        ])
    }
    
    private func setupAuthorAndDateStackView() {
        newsImageView.addSubview(authorAndDateStackView)
        
        NSLayoutConstraint.activate([
            authorAndDateStackView.leftAnchor.constraint(equalTo: newsImageView.leftAnchor, constant: 16),
            authorAndDateStackView.rightAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: -16),
            authorAndDateStackView.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -8),
            authorAndDateStackView.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 30)
        ])
        
        authorAndDateStackView.addArrangedSubview(newsAuthor)
        authorAndDateStackView.addArrangedSubview(newsPublishDate)
    }
    
    func configureCell(with article: Article) {
        newsTitle.text = article.title
        newsAuthor.text = article.author
        newsImageView.imageFrom(url: URL(string: article.urlToImage)!)
        newsPublishDate.text = newsListViewModel.formatDate(date: article.publishedAt ?? "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
}
