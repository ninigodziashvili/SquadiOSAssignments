


import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    private var viewModel = GameViewModel()
    private let animation = Animations()
    let curryImageView = UIImageView()
    private let basketballView = UIImageView()
    private let scoreLabel = UILabel()
    private var startButton = UIButton()
    var isDragging = false
    private var mvpLabel = UILabel()
    private var newGameButton = UIButton()
    private var newGameLabel = UILabel()
    private var newGame = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startButtonConfig()
        viewModelUpdates()
    }
    
    private func setupUI() {
        basketballViewConfig()
        scoreLabelConfig()
        imageViewConfig()
        startButton.setTitle("", for: .normal)
        mvpLabelConfig()
        newGameButtonConfig()
    }
    
    private func basketballViewConfig() {
        view.addSubview(basketballView)
        basketballView.translatesAutoresizingMaskIntoConstraints = false
        basketballView.image = UIImage(named: "ball")
        NSLayoutConstraint.activate([
            basketballView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketballView.heightAnchor.constraint(equalToConstant: 100),
            basketballView.widthAnchor.constraint(equalToConstant: 100),
            basketballView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        animation.loadBall(basketballView)
    }
    
    private func imageViewConfig() {
        view.addSubview(curryImageView)
        curryImageView.translatesAutoresizingMaskIntoConstraints = false
        curryImageView.image = UIImage(named: "curry")
        curryImageView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            curryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            curryImageView.widthAnchor.constraint(equalToConstant: 100),
            curryImageView.heightAnchor.constraint(equalToConstant: 150),
            curryImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        animation.loadCharacter(curryImageView)
    }
    
    private func scoreLabelConfig() {
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        scoreLabel.textColor = .orange
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }
    
    private func newGameButtonConfig() {
        view.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitle("New game", for: .normal)
        newGameButton.setTitleColor(.black, for: .normal)
        
        NSLayoutConstraint.activate([
            newGameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newGameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            newGameButton.heightAnchor.constraint(equalToConstant: 30),
            newGameButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        newGameButton.addAction(UIAction(handler: { [weak self] action in
            self?.viewModel.restart()
        }), for: .touchUpInside)
    }
    
    private func mvpLabelConfig() {
        view.addSubview(mvpLabel)
        mvpLabel.translatesAutoresizingMaskIntoConstraints = false
        mvpLabel.text = "M V P"
        mvpLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        mvpLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            mvpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mvpLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mvpLabel.heightAnchor.constraint(equalToConstant: 50),
            mvpLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        animation.animateMVPlabel(mvpLabel)
    }
    
    private func startButtonConfig() {
        view.addSubview(startButton)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.orange, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        startButton.addAction(UIAction(handler: { [weak self] action in
            self?.startGame()
            self?.setupUI()
        }), for: .touchUpInside)
    }
    
    private func startGame() {
        viewModel.resetBallPosition(viewWidth: view.frame.width, basketballViewWidth: basketballView.frame.width)
        viewModel.startBallFall()
    }
    
    private func viewModelUpdates() {
        viewModel.scoreUpdated = { [weak self] score in
            self?.scoreLabel.text = "Score: \(score)"
        }
  
        viewModel.ballPositionUpdated = { [weak self] ballPosition in
            self?.basketballView.frame.origin = ballPosition
        }
  
        viewModel.gameOver = { [weak self] in
            self?.showGameOverAlert()
        }
    }
    
    private func showGameOverAlert() {
        let ac = UIAlertController(title: "Curry for three, baaang", message: "🏆", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: { [weak self] action in
            self?.restartGame()
        }))
        present(ac, animated: true)
    }
    
    private func restartGame() {
        viewModel.restart()
        viewModel.resetBallPosition(viewWidth: view.frame.width, basketballViewWidth: basketballView.frame.width)
    }
    
      private func updateCharacterFrame() {
          viewModel.characterFrame = curryImageView.frame
      }

      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          updateCharacterFrame()
          basketballView.translatesAutoresizingMaskIntoConstraints = true
      }
}

struct viewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ViewController
    
    
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

struct viewController_Previews: PreviewProvider {
    static var previews: some View {
        viewControllerRepresentable()
    }
}
