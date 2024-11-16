//
//  BananaMonkeyGameViewController.swift
//  AnimationTest
//
//  Created by Imac on 15.11.24.
//

//
//  BananaMonkeyGameViewController.swift
//  AnimationTest
//
//  Created by Imac on 15.11.24.
//

//
//  BananaMonkeyGameViewController.swift
//  AnimationTest
//
//  Created by Imac on 15.11.24.
//

import UIKit

class BananaMonkeyGameViewController: UIViewController {
    private let bananaImageView = UIImageView(image: UIImage(named: "Mac"))
    private let evilBananaImageView = UIImageView(image: UIImage(named: "evilBanana"))
    private let monkeyImageView = UIImageView(image: UIImage(named: "Steve"))
    private let scoreLabel = UILabel()
    private let startButton = UIButton()
    private var isStartButtonShown = true
    private var gameOverAlertShown = false

    
    private var viewModel = GameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        if isStartButtonShown {
              startButton.isHidden = false
          }
    }

    private func setupUI() {
        if isStartButtonShown {
              setupStartButton()
          }
        setupStartButton()
        setupBanana()
        setupEvilBanana()
        setupMonkey()
        setupScoreLabel()
    }

    private func setupStartButton() {
        startButton.frame = CGRect(x: view.bounds.midX - 75, y: view.bounds.midY - 25, width: 150, height: 50)
        startButton.backgroundColor = .white
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.orange, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        view.addSubview(startButton)
    }

    private func setupBanana() {
        bananaImageView.frame = CGRect(x: view.bounds.midX - 35, y: 0, width: 70, height: 70)
        bananaImageView.isHidden = true
        view.addSubview(bananaImageView)
    }



    private func setupEvilBanana() {
        evilBananaImageView.frame = CGRect(x: CGFloat.random(in: 0..<view.bounds.width - 70), y: -200, width: 70, height: 70)
        evilBananaImageView.isHidden = true
        view.addSubview(evilBananaImageView)
    }

    private func setupMonkey() {
        monkeyImageView.frame = CGRect(x: 0, y: view.bounds.height - 200, width: 120, height: 120)
        monkeyImageView.isHidden = true
        view.addSubview(monkeyImageView)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        monkeyImageView.addGestureRecognizer(panGesture)
        monkeyImageView.isUserInteractionEnabled = true
    }

    private func setupScoreLabel() {
        scoreLabel.frame = CGRect(x: 16, y: 80, width: 100, height: 24)
        scoreLabel.textColor = .orange
        scoreLabel.font = .systemFont(ofSize: 18, weight: .bold)
        scoreLabel.text = "Score: 0"
        scoreLabel.isHidden = true
        view.addSubview(scoreLabel)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if let view = gesture.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y)
        }
        gesture.setTranslation(.zero, in: view)
    }

    @objc private func startGame() {
        if !isStartButtonShown { return }
            isStartButtonShown = false
        startButton.isHidden = true
        bananaImageView.isHidden = false
        evilBananaImageView.isHidden = false
        monkeyImageView.isHidden = false
        scoreLabel.isHidden = false
        scoreLabel.text = viewModel.scoreText

        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.moveBanana()
            self.moveEvilBanana()
            self.checkCollisions()
        }

        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.activateEvilBanana()
        }
    }

    private func moveBanana() {
        UIView.animate(withDuration: 0.05) {
            self.bananaImageView.frame.origin.y += self.viewModel.model.bananaSpeed
        } completion: { _ in
            if self.bananaImageView.frame.origin.y >= self.view.bounds.height {
                self.showGameOverAlert()
            }
        }
    }


    private func moveEvilBanana() {
        guard viewModel.model.evilBananaActive else { return }
        UIView.animate(withDuration: 0.05) {
            self.evilBananaImageView.frame.origin.y += self.viewModel.model.evilBananaSpeed
        } completion: { _ in
            if self.evilBananaImageView.frame.origin.y >= self.view.bounds.height {
                self.resetEvilBanana()
            }
        }
    }

    private func checkCollisions() {
        if bananaImageView.frame.intersects(monkeyImageView.frame) {
            viewModel.catchBanana()
            scoreLabel.text = viewModel.scoreText
            resetBanana()
        }


        if viewModel.model.evilBananaActive && evilBananaImageView.frame.intersects(monkeyImageView.frame) {
            viewModel.catchEvilBanana {
                self.scoreLabel.text = self.viewModel.scoreText
            }
            resetEvilBanana()
        }
    }

    private func resetBanana() {
        viewModel.model.bananaSpeed += 3
        bananaImageView.frame.origin.y = 0
        bananaImageView.frame.origin.x = CGFloat.random(in: 0..<view.bounds.width - 70)
    }


    private func resetEvilBanana() {
        evilBananaImageView.isHidden = true
        evilBananaImageView.frame.origin.y = -200
        viewModel.model.evilBananaActive = false
    }


    private func activateEvilBanana() {
        viewModel.model.evilBananaActive = true
        evilBananaImageView.isHidden = false
    }

    private func showGameOverAlert() {
        if gameOverAlertShown { return }
        gameOverAlertShown = true
        let alert = UIAlertController(title: "Winner Winner Chicken Dinner", message: "I think \(viewModel.model.gameScore) will be enough", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start Again", style: .default) { [weak self] _ in
            self?.resetGame()
        })
        present(alert, animated: true)
    }

    private func resetGame() {
        gameOverAlertShown = false
        viewModel.resetGame {
            scoreLabel.text = viewModel.scoreText
            resetBanana()
            resetEvilBanana()
        }
    }
}
