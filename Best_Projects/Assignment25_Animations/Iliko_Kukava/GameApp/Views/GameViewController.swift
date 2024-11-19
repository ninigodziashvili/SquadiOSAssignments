//
//  GameController.swift
//  GameApp
//
//  Created by iliko on 11/15/24.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    private let monkey = UIImageView()
    private let banana = UIImageView()
    private let banana2 = UIImageView()
    private let scoreLabel = UILabel()
    private var displayLink: CADisplayLink?
    
    private var viewModel: GameViewModel!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        startGame()
    }
    
    // MARK: - ViewModel Setup
    
    private func setupViewModel() {
        viewModel = GameViewModel()
        
        viewModel.updateUI = { [weak self] bananaFrame, banana2Frame, score, banana2RotationAngle in
            self?.banana.frame = bananaFrame
            self?.banana2.frame = banana2Frame
            self?.scoreLabel.text = "Score: \(score)"
            
            self?.banana2.transform = CGAffineTransform(rotationAngle: banana2RotationAngle)
        }
        
        viewModel.notifyGameOver = { [weak self] in
            self?.showGameOverAlert()
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white

        monkey.image = UIImage(named: "monkey_3")
        monkey.frame = CGRect(x: view.bounds.midX - 80, y: view.bounds.height - 180, width: 160, height: 160)
        monkey.contentMode = .scaleAspectFit
        monkey.isUserInteractionEnabled = true
        monkey.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        view.addSubview(monkey)
        
        banana.image = UIImage(named: "banana_1")
        banana.contentMode = .scaleAspectFit
        view.addSubview(banana)
        
        banana2.image = UIImage(named: "banana_2")
        banana2.contentMode = .scaleAspectFit
        banana2.frame = CGRect(x: 50, y: -80, width: 80, height: 80)
        view.addSubview(banana2)
        
        scoreLabel.frame = CGRect(x: 20, y: 50, width: 150, height: 50)
        scoreLabel.textColor = .systemOrange
        scoreLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
    }
    
    // MARK: - Game Flow

    private func startGame() {
        viewModel.startGame(viewWidth: view.bounds.width)
        setupDisplayLink()
    }
    
    private func setupDisplayLink() {
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(updateGameState))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    // MARK: - User Interaction Methods

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if let player = gesture.view {
            player.frame = viewModel.handlePan(monkeyFrame: player.frame, translation: translation, viewSize: view.bounds.size)
            gesture.setTranslation(.zero, in: view)
        }
    }
    
    // MARK: - Game State Update
    
    @objc private func updateGameState() {
        viewModel.updateGameState(viewWidth: view.bounds.width, viewHeight: view.bounds.height, monkeyFrame: monkey.frame)
    }
    
    // MARK: - Game Finish

    private func showGameOverAlert() {
        displayLink?.invalidate()
        
        let alert = UIAlertController(title: "Winner winner chicken dinner", message: "I think 20 bananas will be enough ^_^", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start Again", style: .default, handler: { [weak self] _ in
            self?.restartGame()
        }))
        present(alert, animated: true)
    }

    private func restartGame() {
        startGame()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Cleanup
    
    deinit {
        displayLink?.invalidate()
    }
}

