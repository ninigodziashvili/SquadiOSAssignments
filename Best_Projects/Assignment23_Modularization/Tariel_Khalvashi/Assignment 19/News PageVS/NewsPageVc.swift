import UIKit
import NetworkingForNews
import FormattingModule

class NewsPageVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var viewModel: NewsPageViewModel!
    private var articles: [NewsArticle] = []
    
    private lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsPageCell.self, forCellWithReuseIdentifier: NewsPageCell.identifier)
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Latest News"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        self.viewModel = NewsPageViewModel()
        self.viewModel.didUpdateArticles = { [weak self] articles in
            DispatchQueue.main.async {
                self?.articles = articles
                self?.newsCollectionView.reloadData()
            }
        }
        
        self.viewModel.didFailWithError = { error in
            print("Failed to fetch articles: \(error)")
        }
        
        self.viewModel.fetchNews()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(newsCollectionView)
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            newsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsPageCell.identifier, for: indexPath) as? NewsPageCell else {
            return UICollectionViewCell()
        }
        
        let article = articles[indexPath.row]
        cell.configure(article: article, viewModel: viewModel)
        return cell
    }
}


extension NewsPageVc {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedArticle = articles[indexPath.row]
        let detailsVC = DetailsPageVc()
        
        detailsVC.article = selectedArticle
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
