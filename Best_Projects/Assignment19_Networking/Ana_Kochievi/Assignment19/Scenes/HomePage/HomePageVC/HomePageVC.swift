//
//  ViewController.swift
//  Assignment19
//
//  Created by MacBook on 30.10.24.
//

import UIKit

final class HomePageVC: UIViewController {
    
    private lazy var homePageTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomePageCell.self, forCellReuseIdentifier: HomePageCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var homePageViewModel = HomePageViewModel()
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        homePageTableView.tableHeaderView = headerView
        
        view.addSubview(homePageTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homePageTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homePageTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homePageTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            homePageTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupViewModel() {
        homePageViewModel.onDataUpdated = { [weak self] in
            self?.articles = self?.homePageViewModel.allArticles ?? []
            DispatchQueue.main.async {
                self?.homePageTableView.reloadData()
            }
        }
        homePageViewModel.fetchData(page: 1)
    }
}

extension HomePageVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homePageViewModel.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageCell.identifier, for: indexPath) as? HomePageCell else { return UITableViewCell() }
        
        let article = homePageViewModel.article(at: indexPath.row)
        cell.configureCell(with: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsPageVC()
        
        let selectedArticle = homePageViewModel.article(at: indexPath.row)
        vc.article = selectedArticle
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        136
    }
}


extension HomePageVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let threshold = contentHeight - scrollView.frame.size.height
        
        if offsetY > threshold && !homePageViewModel.isFetching && homePageViewModel.hasMoreData {
            homePageViewModel.loadMoreData()
        }
    }
}
