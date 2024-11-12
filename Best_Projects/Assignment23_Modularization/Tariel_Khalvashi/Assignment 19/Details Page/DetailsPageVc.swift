import UIKit
import NetworkingForNews
import FormattingModule

class DetailsPageVc: UIViewController {
    
    private let titleLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let contentLabel = UILabel()
    private let newsMainImageView = UIImageView()
    
    var article: NewsArticle? {
        didSet {
            configureView()
        }
    }
    
    private let dateFormatter = DateFormatterForNews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        publishedDateLabel.font = UIFont.systemFont(ofSize: 14)
        publishedDateLabel.textColor = .gray
        view.addSubview(publishedDateLabel)
        
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        view.addSubview(contentLabel)
        
        newsMainImageView.contentMode = .scaleAspectFill
        newsMainImageView.clipsToBounds = true
        newsMainImageView.layer.cornerRadius = 5
        newsMainImageView.layer.masksToBounds = true
        view.addSubview(newsMainImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        newsMainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            publishedDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            publishedDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            publishedDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            newsMainImageView.topAnchor.constraint(equalTo: publishedDateLabel.bottomAnchor, constant: 12),
            newsMainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newsMainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            newsMainImageView.heightAnchor.constraint(equalToConstant: 200),
            
            contentLabel.topAnchor.constraint(equalTo: newsMainImageView.bottomAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureView() {
        guard let article = article else { return }
        
        titleLabel.text = article.title
        publishedDateLabel.text = dateFormatter.formatDate(article.publishedAt)
        contentLabel.text = article.content
        
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.newsMainImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
