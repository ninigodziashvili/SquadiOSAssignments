//
//  NewsService.swift
//  Network
//
//  Created by Beka on 10.11.24.
//

import Foundation

public protocol NewsServiceProtocol: Sendable {
    func fetchNews(page: Int, pageSize: Int, completion: @escaping @Sendable ([NewsArticle]) -> Void)
}

public final class NewsService: NewsServiceProtocol, Sendable {
    public init(){}
    public func fetchNews(page: Int, pageSize: Int, completion: @escaping @Sendable ([NewsArticle]) -> Void) {
        let apiKey = "967b09ab27394e269ee6f25ef2579253"
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&country=us&page=\(page)&pageSize=\(pageSize)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let articlesResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(articlesResponse.articles)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}
