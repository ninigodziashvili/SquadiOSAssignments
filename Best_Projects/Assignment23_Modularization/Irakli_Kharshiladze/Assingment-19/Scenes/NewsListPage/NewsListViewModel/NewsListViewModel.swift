//
//  NewsListViewModel.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//
import Foundation
import NetworkPackage
import DateFormatterUtility

final class NewsListViewModel {
    private let networkService: NetworkServiceProtocol
    private let dateFormatter: CustomDateFormatterProtocol
    
    private var articles: [Article] = []
    var currentPage: Int = 1
    private var isFetching: Bool = false
    private let apiKey: String = "05ef21c598fa49b99e1880e226342bcf"
    
    init(networkService: NetworkServiceProtocol = NetworkService(), dateFormatter: CustomDateFormatterProtocol = CustomDateFormatter()) {
        self.networkService = networkService
        self.dateFormatter = dateFormatter
        fetchNewsData(page: currentPage)
    }
    
    var numberOfArticles: Int {
        articles.count
    }
    
    var articlesChanged: (() -> Void)?
    
    func article(at index: Int) -> Article {
        articles[index]
    }
    
    func formatDate(date: String, inputFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ", outputFormat: String = "EEEE, d MMMM yyyy") -> String {
        return dateFormatter.formattedDate(from: date, inputFormat: inputFormat, outputFormat: outputFormat)
    }
    
    func fetchNewsData(page: Int) {
        guard !isFetching else { return }
        
        isFetching = true
        let urlString = "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&pageSize=10&page=\(page)&apiKey=\(apiKey)"
        
        networkService.fetchData(urlString: urlString, httpMethod: "GET", headers: nil, decoder: JSONDecoder()) { [weak self] (result: Result<News, NetworkError>) in
            switch result {
            case .success(let newsData):
                let newArticles = newsData.articles
                self?.articles.append(contentsOf: newArticles)
                self?.currentPage += 1
                self?.articlesChanged?()
                self?.isFetching = false
                
            case .failure(let error):
                print("Error fetching data: \(error)")
                self?.isFetching = false
            }
        }
    }
}
