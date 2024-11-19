//
//  GameViewController.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class GameViewController: UIViewController {
    
    var viewModel: GameViewModel!
    var monkeyImageView: UIImageView!
    var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        monkeyImageView = UIImageView(image: UIImage(named: "monkey"))
       
        monkeyImageView.frame = CGRect(x: view.frame.size.width / 2 - 50, y: view.frame.size.height - 150, width: 100, height: 100)
        
        view.addSubview(monkeyImageView)

        setupScoreLabel()

        let gameModel = GameModel()
        viewModel = GameViewModel(monkey: monkeyImageView, gameModel: gameModel)
        
        viewModel.onScoreUpdated = { [weak self] score in
            self?.scoreLabel.text = "Score: \(score)"
        }
        
        viewModel.onGameOver = { [weak self] in
            self?.gameOver()
        }
        
        viewModel.onBananaAdded = { [weak self] banana in
            self?.view.addSubview(banana)
        }

        Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(spawnBanana), userInfo: nil, repeats: true)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveMonkey(gesture:)))
        view.addGestureRecognizer(panGesture)
    }

    func setupScoreLabel() {
        scoreLabel = UILabel()
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }

    @objc func moveMonkey(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let newPosition = CGPoint(x: monkeyImageView.center.x + translation.x, y: monkeyImageView.center.y + translation.y)

        let maxX = view.frame.size.width - monkeyImageView.frame.width / 2
        let maxY = view.frame.size.height - monkeyImageView.frame.height / 2
        let safeX = min(max(newPosition.x, monkeyImageView.frame.width / 2), maxX)
        let safeY = min(max(newPosition.y, monkeyImageView.frame.height / 2), maxY)

        viewModel.moveMonkey(to: CGPoint(x: safeX, y: safeY))
        gesture.setTranslation(.zero, in: view)
    }

    @objc func spawnBanana() {
        viewModel.spawnBanana(view: view)
    }

    @objc func updateGame() {
        viewModel.updateGame()
    }

    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "You caught 20 bananas!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartGame()
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: .cancel, handler: { _ in
            self.exitGame()
        }))
        present(alert, animated: true)
    }

    func restartGame() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    func exitGame() {
        navigationController?.popToRootViewController(animated: true)
    }
}
