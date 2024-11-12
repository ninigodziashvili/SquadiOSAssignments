//
//  NewsListViewController.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import UIKit
import Network
import DateFormater

public class NewsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var viewModel = NewsViewModel(newsService: NewsService())

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsArticleCell.self, forCellReuseIdentifier: NewsArticleCell.identifier)
        view.addSubview(tableView)
    }

    private func loadData() {
        viewModel.fetchArticles { [weak self] in
            DispatchQueue.main.async {
                print("Number of articles fetched: \(self?.viewModel.numberOfArticles() ?? 0)")
                self?.tableView.reloadData()
            }
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleCell.identifier, for: indexPath) as! NewsArticleCell
        let article = viewModel.article(at: indexPath.row)

        print("Configuring cell for article: \(article.title)")
        cell.imageHeight = 150
        cell.configure(with: article)

        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.article(at: indexPath.row)
        let detailsVC = NewsDetailViewController(article: article, dateformatter: DateFormater())
        navigationController?.pushViewController(detailsVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.fetchIfNeeded(row: indexPath.row) {
            DispatchQueue.main.async { [weak self] in
                print("Number of articles fetched: \(self?.viewModel.numberOfArticles() ?? 0)")
                self?.tableView.reloadData()
            }
        }
    }
}
