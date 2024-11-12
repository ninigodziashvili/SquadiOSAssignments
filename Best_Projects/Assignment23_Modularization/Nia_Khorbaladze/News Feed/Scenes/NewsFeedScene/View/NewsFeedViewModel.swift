//
//  NewsFeedViewModel.swift
//  News Feed
//
//  Created by Nkhorbaladze on 30.10.24.
//

import UIKit
import NetworkService
import CustomDateFormatter

final class NewsFeedViewModel {
    
    var newsUpdated: (() -> Void)?
    var articles: [Article] = []
    
    private var page = 1
    private var totalResults = 0
    private var reloadNext = true
    
    private let networkService: NetworkServiceProtocol
    var dateFormatter: DateFormatterHelper
    
    init(networkService: NetworkServiceProtocol, dateFormatter: DateFormatterHelper) {
        self.networkService = networkService
        self.dateFormatter = dateFormatter
    }
    
    func getData() {
        guard reloadNext else { return }
        networkService.getData(urlString: "https://newsapi.org/v2/everything?q=bitcoin", key: "Bearer 446fedc1b568404bb83091035320548a") { [weak self] (result: Result<NewsFeedData, Error>) in
            switch result {
            case .success(let newsData):
                if let newArticles = newsData.articles {
                    self?.articles.append(contentsOf: newArticles)
                    self?.totalResults = newsData.totalResults ?? 0
                    
                    if self?.articles.count ?? 0 < self?.totalResults ?? 0 {
                        self?.reloadNext = true
                        self?.page += 1
                    } else {
                        self?.reloadNext = false
                    }
                }
                
                self?.newsUpdated?()
                
            case .failure(let error):
                print("Failed:", error.localizedDescription)
            }
        }
    }
    
    func loadMoreData(currentIndex: Int) {
        if currentIndex == articles.count - 2 {
            page += 1
            getData()
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        networkService.getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    func formatDate(_ dateFromResponse: String?) -> String? {
        return dateFormatter.formatDate(dateFromResponse)
    }
}


