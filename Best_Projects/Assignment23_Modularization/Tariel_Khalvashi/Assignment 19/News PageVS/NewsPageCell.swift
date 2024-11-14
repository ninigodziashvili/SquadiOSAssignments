import UIKit
import NetworkingForNews

final class NewsPageCell: UICollectionViewCell {
    static let identifier = "NewsPageCell"
    private var viewModel: NewsPageViewModel?
    
    
    private let avatar: UIImageView = {
        let imageOfArticle = UIImageView()
        imageOfArticle.layer.cornerRadius = 10
        imageOfArticle.layer.masksToBounds = true
        imageOfArticle.contentMode = .scaleAspectFill
        imageOfArticle.clipsToBounds = true
        
        return imageOfArticle
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [avatar, contentLabel, titleLabel, authorLabel, publishedAtLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: avatar.topAnchor, constant: -10),
            contentLabel.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 10),
            contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40),
            
            titleLabel.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: -20),
            
            authorLabel.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 10),
            authorLabel.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -20),
            
            publishedAtLabel.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -20),
            publishedAtLabel.rightAnchor.constraint(equalTo: avatar.rightAnchor, constant: -20)
        ])
    }
    
    func configure(article: NewsArticle, viewModel: NewsPageViewModel) {
        self.viewModel = viewModel
        contentLabel.text = article.description
        titleLabel.text = article.title
        authorLabel.text = article.author
        publishedAtLabel.text = viewModel.formattedDate(for: article)
        
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            loadImage(from: url)
        } else {
            avatar.image = UIImage(systemName: "photo")
        }
        
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.avatar.image = UIImage(data: data)
            }
        }.resume()
    }
}
