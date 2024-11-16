//
//  GameViewController.swift
//  Lecture_25
//
//  Created by Giorgi Matiashvili on 15.11.24.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    private let viewModel = GameViewModel()
    private var monkeyImageView: UIImageView!
    private var bananaImageView: UIImageView!
    private var superBananaImageView: UIImageView!
    private var scoreLabel: UILabel!
    private var fallingSpeed: CGFloat = 2.0
    private var bananaTimer: Timer?
    private var superBananaTimer: Timer?
    private var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        startGame()
        playBackgroundMusic()
    }

    private func setupUI() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "tarzan")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        monkeyImageView = UIImageView(image: UIImage(named: "monkeyImage"))
        monkeyImageView.frame = CGRect(x: view.bounds.midX - 50, y: view.bounds.height - 150, width: 100, height: 100)
        view.addSubview(monkeyImageView)
        
        //gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        monkeyImageView.isUserInteractionEnabled = true
        monkeyImageView.addGestureRecognizer(panGesture)
        
        scoreLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 200, height: 50))
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        scoreLabel.textColor = .white
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        bananaImageView = UIImageView(image: UIImage(named: "bananaImage"))
        resetBananaPosition()
        view.addSubview(bananaImageView)
        
        superBananaImageView = UIImageView(image: UIImage(named: "superBanana"))
        resetSuperBananaPosition()
        view.addSubview(superBananaImageView)
    }

    private func bindViewModel() {
        viewModel.onScoreUpdate = { [weak self] score in
            self?.scoreLabel.text = "Score: \(score)"
                       if score == 20 {
                self?.presentGoldenBananaPopup()
            }
        }
        
        viewModel.onGameOver = { [weak self] in
            self?.showGameOver()
        }
    }

    private func startGame() {
        bananaTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateBananaPosition), userInfo: nil, repeats: true)
        
        superBananaTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(dropSuperBanana), userInfo: nil, repeats: true)
    }

    private func resetBananaPosition() {
        bananaImageView.frame = CGRect(x: CGFloat.random(in: 0...(view.bounds.width - 50)), y: -50, width: 50, height: 50)
    }

    private func resetSuperBananaPosition() {
        superBananaImageView.frame = CGRect(
            x: CGFloat.random(in: 0...(view.bounds.width - 60)),y: -60,width: 60, height: 60)
        superBananaImageView.transform = .identity
        superBananaImageView.isHidden = false
    }

    private func increaseSpeed() {
        fallingSpeed += 0.5
    }

    @objc private func updateBananaPosition() {
        var bananaFrame = bananaImageView.frame
        bananaFrame.origin.y += fallingSpeed
        bananaImageView.frame = bananaFrame

        if bananaFrame.intersects(monkeyImageView.frame) {
            viewModel.catchBanana()
            increaseSpeed()
            resetBananaPosition()
        } else if bananaFrame.origin.y > view.bounds.height {
            viewModel.missBanana()
            resetBananaPosition()
        }
    }

    @objc private func dropSuperBanana() {
        resetSuperBananaPosition()

        let collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            //amit xo unda icherdes da rato ver ichers???
            if self.superBananaImageView.frame.intersects(self.monkeyImageView.frame) {
                self.viewModel.catchBanana()
                self.viewModel.catchBanana() //orjer imito ro superze 2 qula minda
                self.increaseSpeed()
                self.superBananaImageView.isHidden = true
                self.resetSuperBananaPosition()
                timer.invalidate()
            }

            if self.superBananaImageView.frame.origin.y > self.view.bounds.height {
                self.resetSuperBananaPosition()
                timer.invalidate()
            }
        }

        //super banana anim
        UIView.animate(withDuration: 5.0, animations: {
            self.superBananaImageView.frame.origin.y = self.view.bounds.height
            self.superBananaImageView.transform = CGAffineTransform(rotationAngle: .pi)
        })
    }

    private func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "Phil Collins - You'll Be in My Heart Tarzan", withExtension: "mp3") else {
            print("Error: Background music file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Error: Could not play background music - \(error.localizedDescription)")
        }
    }

    private func showGameOver() {
        bananaTimer?.invalidate()
        superBananaTimer?.invalidate()
        audioPlayer?.stop()

        let gameOverVC = GameOverViewController(
            finalScore: viewModel.model.bananasCaught,
            onPlayAgain: { [weak self] in
                self?.resetGame()
            }
        )
        present(gameOverVC, animated: true, completion: nil)
    }

    private func resetGame() {
        viewModel.resetGame()
        scoreLabel.text = "Score: 0"
        fallingSpeed = 2.0
        playBackgroundMusic()
        startGame()
    }

    private func presentGoldenBananaPopup() {
        let popupVC = GoldenBananaPopupViewController(
            onPlayAgain: { [weak self] in
                self?.resetGame()
            }
        )
        present(popupVC, animated: true, completion: nil)
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if let monkey = gesture.view {
            var newX = monkey.center.x + translation.x
            newX = max(monkey.bounds.width / 2, newX)
            newX = min(view.bounds.width - monkey.bounds.width / 2, newX)
            monkey.center.x = newX
        }
        gesture.setTranslation(.zero, in: view)
    }
}
