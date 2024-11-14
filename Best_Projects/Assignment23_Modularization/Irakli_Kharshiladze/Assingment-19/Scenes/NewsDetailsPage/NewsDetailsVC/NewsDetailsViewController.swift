//
//  NewsDetailsViewController.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

import UIKit
import DateFormatterUtility

class NewsDetailsViewController: UIViewController {
    private let navigationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let detailsPageTitle: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Hot Updates", font: UIFont(name: "AnekDevanagari-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24), textColor: .label, alignment: .left)
        
        return label
    }()
    
    private let detailsPageWrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let articleTitleAndPublishDateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let articleTitle: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18), textColor: .label, alignment: .left, numberOfLines: 0)
        
        return label
    }()
    
    private let articlePublishDate: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Light", size: 16) ?? UIFont.systemFont(ofSize: 16), textColor: .label, alignment: .left)
        
        return label
    }()
    
    private let articleDetailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let articleDescription: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Light", size: 16) ?? UIFont.systemFont(ofSize: 16), textColor: .label, alignment: .left, numberOfLines: 0)
        
        return label
    }()
    
    private let articlePublishedByView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let articlePublishedByTitle: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Published by", font: UIFont(name: "Nunito-Bold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14), textColor: .label, alignment: .left)
        
        return label
    }()
    
    private let articlePublishedByTitleValue: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "", font: UIFont(name: "Nunito-Bold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14), textColor: .label, alignment: .left)
        
        return label
    }()
    
    private let articleDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    var article: Article? = nil
    
    private let newsDetailsViewModel = NewsDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        setupNewsTitle()
        setupNavigationButton()
        setupDetailsPageWrapperView()
        setupArticleTitleAndPublishDateView()
        setupArticleTitleAndPublishDate()
        setupArticleTitleAndPublishDate()
        setupArticleDetailsView()
        setupArticleImageView()
        setupArticleDescription()
        setupArticlePublishedByView()
        setupArticlePublishedBy()
    }
    
    private func setupNewsTitle() {
        view.addSubview(detailsPageTitle)
        
        NSLayoutConstraint.activate([
            detailsPageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsPageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
    }
    
    private func setupNavigationButton() {
        view.addSubview(navigationButton)
        
        NSLayoutConstraint.activate([
            navigationButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            navigationButton.centerYAnchor.constraint(equalTo: detailsPageTitle.centerYAnchor)
        ])
        
        navigationButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupDetailsPageWrapperView() {
        view.addSubview(detailsPageWrapperView)
        
        NSLayoutConstraint.activate([
            detailsPageWrapperView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            detailsPageWrapperView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            detailsPageWrapperView.topAnchor.constraint(equalTo: detailsPageTitle.bottomAnchor, constant: 30),
            detailsPageWrapperView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupArticleTitleAndPublishDateView() {
        detailsPageWrapperView.addSubview(articleTitleAndPublishDateView)
        
        NSLayoutConstraint.activate([
            articleTitleAndPublishDateView.leftAnchor.constraint(equalTo: detailsPageWrapperView.leftAnchor),
            articleTitleAndPublishDateView.rightAnchor.constraint(equalTo: detailsPageWrapperView.rightAnchor),
            articleTitleAndPublishDateView.topAnchor.constraint(equalTo: detailsPageWrapperView.topAnchor),
        ])
    }
    
    private func setupArticleTitleAndPublishDate() {
        articleTitleAndPublishDateView.addSubview(articleTitle)
        articleTitleAndPublishDateView.addSubview(articlePublishDate)
        
        NSLayoutConstraint.activate([
            articleTitle.leftAnchor.constraint(equalTo: articleTitleAndPublishDateView.leftAnchor),
            articleTitle.rightAnchor.constraint(equalTo: articleTitleAndPublishDateView.rightAnchor),
            articleTitle.topAnchor.constraint(equalTo: articleTitleAndPublishDateView.topAnchor),
            articlePublishDate.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            articlePublishDate.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10),
        ])
        
        articleTitle.text = article?.title
        articlePublishDate.text = newsDetailsViewModel.formatDate(date: article?.publishedAt ?? "")
    }
    
    private func setupArticleDetailsView() {
        detailsPageWrapperView.addSubview(articleDetailsView)
        
        NSLayoutConstraint.activate([
            articleDetailsView.leftAnchor.constraint(equalTo: detailsPageWrapperView.leftAnchor),
            articleDetailsView.rightAnchor.constraint(equalTo: detailsPageWrapperView.rightAnchor),
            articleDetailsView.topAnchor.constraint(equalTo: articleTitleAndPublishDateView.bottomAnchor),
            articleDetailsView.bottomAnchor.constraint(equalTo: detailsPageWrapperView.bottomAnchor),
            articleDetailsView.heightAnchor.constraint(equalTo: detailsPageWrapperView.heightAnchor, multiplier: 5/6)
        ])
    }
    
    private func setupArticleImageView() {
        articleDetailsView.addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.leftAnchor.constraint(equalTo: articleDetailsView.leftAnchor),
            articleImageView.topAnchor.constraint(equalTo: articleDetailsView.topAnchor, constant: 5),
            articleImageView.rightAnchor.constraint(equalTo: articleDetailsView.rightAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 144)
        ])
        
        articleImageView.imageFrom(url: URL(string: article?.urlToImage ?? "")!)
    }
    
    private func setupArticleDescription() {
        articleDetailsView.addSubview(articleDescription)
        
        NSLayoutConstraint.activate([
            articleDescription.leftAnchor.constraint(equalTo: articleDetailsView.leftAnchor),
            articleDescription.rightAnchor.constraint(equalTo: articleDetailsView.rightAnchor),
            articleDescription.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10)
        ])
        
        articleDescription.text = article?.description
    }
    
    private func setupArticlePublishedByView() {
        articleDescription.addSubview(articlePublishedByView)
        
        NSLayoutConstraint.activate([
            articlePublishedByView.leftAnchor.constraint(equalTo: articleDetailsView.leftAnchor),
            articlePublishedByView.rightAnchor.constraint(equalTo: articleDetailsView.rightAnchor),
            articlePublishedByView.topAnchor.constraint(equalTo: articleDescription.bottomAnchor, constant: 15),
            articlePublishedByView.heightAnchor.constraint(equalTo: articleDescription.heightAnchor, multiplier: 1/4),
        ])
    }
    
    private func setupArticlePublishedBy() {
        articlePublishedByView.addSubview(articlePublishedByTitle)
        articlePublishedByView.addSubview(articlePublishedByTitleValue)
        
        NSLayoutConstraint.activate([
            articlePublishedByTitle.leftAnchor.constraint(equalTo: articlePublishedByView.leftAnchor),
            articlePublishedByTitle.centerYAnchor.constraint(equalTo: articlePublishedByView.centerYAnchor),
            articlePublishedByTitleValue.leadingAnchor.constraint(equalTo: articlePublishedByTitle.trailingAnchor, constant: 25),
            articlePublishedByTitleValue.centerYAnchor.constraint(equalTo: articlePublishedByTitle.centerYAnchor),
        ])
        
        articlePublishedByTitleValue.text = article?.author
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
