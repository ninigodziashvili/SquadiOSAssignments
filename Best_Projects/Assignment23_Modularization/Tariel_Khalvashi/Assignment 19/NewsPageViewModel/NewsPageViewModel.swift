import Foundation
import NetworkingForNews
import FormattingModule

public class NewsPageViewModel {
    
    private let networkingService: NetworkingProtocol
    private let formattingService: FormattingProtocol
    private var articles: [NewsArticle] = []
    
    public var didUpdateArticles: (([NewsArticle]) -> Void)?
    public var didFailWithError: ((Error) -> Void)?
    
    public init(networkingService: NetworkingProtocol = NetworkingForNews(),
                formattingService: FormattingProtocol = DateFormatterForNews()) {
        self.networkingService = networkingService
        self.formattingService = formattingService
    }
    
    public func fetchNews() {
        networkingService.fetchNewsArticles { result in
            switch result {
            case .success(let articles):
                self.articles = articles
                self.didUpdateArticles?(articles)
            case .failure(let error):
                self.didFailWithError?(error)
            }
        }
    }
    
    public func formattedDate(for article: NewsArticle) -> String {
        return formattingService.formatDate(article.publishedAt)
    }
}
