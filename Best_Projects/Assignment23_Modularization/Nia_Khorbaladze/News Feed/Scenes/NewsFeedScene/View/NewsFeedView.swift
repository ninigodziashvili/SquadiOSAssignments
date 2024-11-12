//
//  NewsFeedView.swift
//  News Feed
//
//  Created by Nkhorbaladze on 30.10.24.
//

import UIKit
import NetworkService
import CustomDateFormatter

final class NewsFeedView: UIViewController {
    
    // MARK: - Elements
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 18)
        label.textColor = .black
        label.text = "Latest News"
        
        return label
    }()
    
    private lazy var newsFeedTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsFeedItemCell.self, forCellReuseIdentifier: NewsFeedItemCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let newsFeedViewModel: NewsFeedViewModel
    private let dateFormatter: DateFormatterHelper
    
    // MARK: - Initialization
    
    init(networkService: NetworkServiceProtocol = NetworkService(), dateFormatter: DateFormatterHelper = DateFormatterHelper()) {
        self.newsFeedViewModel = NewsFeedViewModel(networkService: networkService, dateFormatter: dateFormatter)
        self.dateFormatter = dateFormatter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let networkService = NetworkService()
        self.dateFormatter = DateFormatterHelper()
        self.newsFeedViewModel = NewsFeedViewModel(networkService: networkService, dateFormatter: dateFormatter)
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupViewModel()
        newsFeedViewModel.getData()
    }
    
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(newsFeedTableView)
        setupNewsFeedConstraints()
    }
    
    private func setupViewModel() {
        newsFeedViewModel.newsUpdated = { [weak self] in
            self?.newsFeedTableView.reloadData()
        }
    }
    
    private func setupNewsFeedConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsFeedTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            newsFeedTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newsFeedTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newsFeedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Extensions

extension NewsFeedView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedItemCell.identifier, for: indexPath) as? NewsFeedItemCell else { return UITableViewCell() }
        
        let filteredArticles = newsFeedViewModel.articles.filter { article in
                return !(article.title == "[Removed]") }
        
        let article = filteredArticles[indexPath.row]
        
        let articleIndex = filteredArticles.count - 1 - indexPath.row
        guard articleIndex >= 0 else { return cell }
        
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            newsFeedViewModel.downloadImage(from: imageUrl) { [weak cell] image in
                guard let cell = cell else { return }
                cell.configure(image: image ?? UIImage(named: "Frame 35")!,
                               title: article.title ?? "No Title",
                               author: article.author ?? "No Author",
                               date: self.newsFeedViewModel.formatDate(article.publishedAt) ?? "No Date")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = DetailsView()
        
        let filteredArticles = newsFeedViewModel.articles.filter { article in
                return !(article.title == "[Removed]") }
        
        let articleIndex = filteredArticles.count - 1 - indexPath.row
        guard articleIndex >= 0 else { return }
        
        let article = filteredArticles[indexPath.row]
        
        guard let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) else {
             return
         }
        
        newsFeedViewModel.downloadImage(from: imageUrl) { [weak detailsVC] image in
                guard let detailVC = detailsVC else { return }

            detailVC.configureDetails(title: article.title ?? "No Title", date: article.publishedAt ?? "No Date", image: image ?? UIImage(named: "Frame 35")!, description: article.description ?? "No Description", author: "Published by     \(article.author ?? "No Author")")

            }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        newsFeedViewModel.loadMoreData(currentIndex: indexPath.row)
    }
}
