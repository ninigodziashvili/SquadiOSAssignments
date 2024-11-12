//
//  NewsListViewController.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

import UIKit

class NewsListViewController: UIViewController {
    private let tableViewTitle: UILabel = {
        let label = UILabel()
        label.configureLabel(text: "Latest News", font: UIFont(name: "AnekDevanagari-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 18), textColor: .label, alignment: .left)
        
        return label
    }()
    
    private let articlesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 8
        
        return tableView
    }()
    
    let newsListViewModel = NewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNewsListViewModel()
        setupTableViewTitle()
        setupArticlesListTableView()
    }
    
    private func setupNewsListViewModel() {
        newsListViewModel.articlesChanged = { [weak self] in
            self?.articlesTableView.reloadData()
        }
    }
    
    private func setupTableViewTitle() {
        view.addSubview(tableViewTitle)
        
        NSLayoutConstraint.activate([
            tableViewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 21),
        ])
    }
    
    private func setupArticlesListTableView() {
        view.addSubview(articlesTableView)
        
        NSLayoutConstraint.activate([
            articlesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            articlesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            articlesTableView.topAnchor.constraint(equalTo: tableViewTitle.bottomAnchor, constant: 15),
            articlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        articlesTableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: "NewsListTableViewCell")
        
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListViewModel.numberOfArticles + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == newsListViewModel.numberOfArticles {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {
                return UITableViewCell()
            }
            newsListViewModel.fetchNewsData(page: newsListViewModel.currentPage)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell" , for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        let currentArticle = newsListViewModel.article(at: indexPath.row)
        cell.configureCell(with: currentArticle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentArticle = newsListViewModel.article(at: indexPath.row)
        let vc = NewsDetailsViewController()
        vc.article = currentArticle
        navigationController?.pushViewController(vc, animated: true)
    }
}

