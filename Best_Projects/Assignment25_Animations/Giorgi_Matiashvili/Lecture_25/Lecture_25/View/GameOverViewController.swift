//
//  GameOverViewController.swift
//  Lecture_25
//
//  Created by Giorgi Matiashvili on 15.11.24.
//

import UIKit

class GameOverViewController: UIViewController {
    private var finalScore: Int = 0
    var onPlayAgain: (() -> Void)?

    init(finalScore: Int, onPlayAgain: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.finalScore = finalScore
        self.onPlayAgain = onPlayAgain
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "sadBanana")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        let gameOverLabel = UILabel(frame: CGRect(x: 20, y: view.center.y - 100, width: view.bounds.width - 40, height: 100))
        gameOverLabel.text = "Game Over"
        gameOverLabel.textAlignment = .center
        gameOverLabel.font = UIFont.boldSystemFont(ofSize: 36)
        gameOverLabel.textColor = .white
        view.addSubview(gameOverLabel)
        
        let scoreLabel = UILabel(frame: CGRect(x: 20, y: view.center.y, width: view.bounds.width - 40, height: 50))
        scoreLabel.text = "Score: \(finalScore)"
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.textColor = .white
        view.addSubview(scoreLabel)
        
        let playAgainButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        playAgainButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.setTitleColor(.white, for: .normal)
        playAgainButton.backgroundColor = .blue
        playAgainButton.layer.cornerRadius = 10
        playAgainButton.addTarget(self, action: #selector(playAgainPressed), for: .touchUpInside)
        view.addSubview(playAgainButton)
    }

    @objc private func playAgainPressed() {
        dismiss(animated: true) {
            self.onPlayAgain?()
        }
    }
}
