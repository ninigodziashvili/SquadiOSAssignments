//
//  NewsViewModel.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import Foundation
import Network

final class NewsViewModel: Sendable {
    private let newsService: NewsServiceProtocol
    var articles: [NewsArticle]
    var page = 1
    var pageSize: Int = 10
    
    init (newsService: NewsServiceProtocol, articles: [NewsArticle] = []) {
        self.newsService = newsService
        self.articles = articles
    }
    
    func fetchArticles(completion: @escaping @Sendable () -> Void) {
        newsService.fetchNews(page: page, pageSize: pageSize) { [weak self] articles in
            self?.articles.append(contentsOf: articles)
            completion()
        }
    }
    
    func fetchIfNeeded(row: Int, completion:  @escaping @Sendable () -> Void) {
        if row == articles.count - 1 {
            page += 1
            fetchArticles(completion: completion)
        }
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> NewsArticle {
        return articles[index]
    }
}
