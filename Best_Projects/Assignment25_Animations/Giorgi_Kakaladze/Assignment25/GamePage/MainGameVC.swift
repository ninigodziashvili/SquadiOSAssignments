//
//  ViewController.swift
//  Assignment25
//
//  Created by Gio Kakaladze on 15.11.24.
//
import UIKit

class MainGameVC: UIViewController {

    private let viewModel = MainGameViewModel()
    private var displayLink: CADisplayLink?

    let jungleBackground: UIImageView = {
        let jungleBackground = UIImageView()
        jungleBackground.image = UIImage(named: "jungle")
        jungleBackground.contentMode = .scaleAspectFill
        jungleBackground.translatesAutoresizingMaskIntoConstraints = false
        return jungleBackground
    }()

    let monkeyImage: UIImageView = {
        let monkeyImage = UIImageView()
        monkeyImage.image = UIImage(named: "monkey")
        monkeyImage.contentMode = .scaleAspectFit
        monkeyImage.translatesAutoresizingMaskIntoConstraints = true
        return monkeyImage
    }()

    let bananaImage: UIImageView = {
        let bananaImage = UIImageView()
        bananaImage.image = UIImage(named: "banana")
        bananaImage.contentMode = .scaleAspectFit
        bananaImage.translatesAutoresizingMaskIntoConstraints = true
        return bananaImage
    }()

    let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 25)
        scoreLabel.textColor = .white
        scoreLabel.backgroundColor = .systemGreen
        scoreLabel.layer.cornerRadius = 17
        scoreLabel.textAlignment = .center
        scoreLabel.clipsToBounds = true
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.updateScoreHandler = { [weak self] scoreText in
            self?.scoreLabel.text = scoreText
        }

        viewModel.showAlertHandler = { [weak self] message in
            self?.showGameOverAlert(message: message)
        }

        viewModel.resetBananaPositionHandler = { [weak self] in
            guard let self = self else { return .zero }
            let xPosition = CGFloat.random(in: 10...(self.view.frame.width - self.bananaImage.frame.width))
            self.bananaImage.frame.origin = CGPoint(x: xPosition, y: 0)
            return self.bananaImage.frame.origin
        }
    }

    private func setupUI() {
        setupView()
        monkeyMovement()
        bananaMovement()
    }

    private func setupView() {
        view.addSubview(jungleBackground)
        view.addSubview(scoreLabel)
        view.addSubview(monkeyImage)
        view.addSubview(bananaImage)

        NSLayoutConstraint.activate([
            jungleBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            jungleBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            jungleBackground.topAnchor.constraint(equalTo: view.topAnchor),
            jungleBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            scoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            scoreLabel.widthAnchor.constraint(equalToConstant: 120),
            scoreLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        resetGame()
    }

    private func monkeyMovement() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        monkeyImage.isUserInteractionEnabled = true
        monkeyImage.addGestureRecognizer(panGesture)
        monkeyImage.frame = CGRect(x: view.center.x - 100, y: view.frame.height - 250, width: 150, height: 200)
    }

    private func bananaMovement() {
        bananaImage.frame = CGRect(x: view.center.x - 25, y: 0, width: 80, height: 80)
        startBananaFall()
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let monkeyView = gesture.view else { return }

        let translation = gesture.translation(in: view)

        var newCenterX = monkeyView.center.x + translation.x
        var newCenterY = monkeyView.center.y + translation.y

        let halfWidth = monkeyView.frame.width / 3
        let halfHeight = monkeyView.frame.height / 3
        let maxTopBoundary: CGFloat = 500 + halfHeight

        newCenterX = max(halfWidth, min(view.frame.width - halfWidth, newCenterX))
        newCenterY = max(maxTopBoundary, min(view.frame.height - halfHeight, newCenterY))

        monkeyView.center = CGPoint(x: newCenterX, y: newCenterY)
        gesture.setTranslation(.zero, in: view)
    }

    private func startBananaFall() {
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(updateBananaFall))
        displayLink?.add(to: .current, forMode: .common)
    }

    @objc private func updateBananaFall() {
        bananaImage.frame.origin.y += CGFloat(viewModel.bananaSpeed)
        if viewModel.updateBananaFall(bananaFrame: bananaImage.frame, viewHeight: view.frame.height) {
            displayLink?.invalidate() 
            return
        }
        viewModel.checkForCollision(monkeyFrame: monkeyImage.frame, bananaFrame: bananaImage.frame)
    }

    private func showGameOverAlert(message: String) {
        let alert = UIAlertController(title: message, message: "თქვენ დააგროვეთ \(viewModel.score) ქულა", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.resetGame()
        }))
        present(alert, animated: true, completion: nil)
    }

    private func resetGame() {
        viewModel.resetGame()
        startBananaFall()
    }

    deinit {
        displayLink?.invalidate()
    }
}

