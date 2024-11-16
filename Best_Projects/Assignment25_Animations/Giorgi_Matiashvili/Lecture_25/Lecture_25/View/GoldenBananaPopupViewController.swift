//
//  GoldenBananaPopupViewController.swift
//  Lecture_25
//
//  Created by Giorgi Matiashvili on 15.11.24.
//

import UIKit

class GoldenBananaPopupViewController: UIViewController {
    var onPlayAgain: (() -> Void)?

    init(onPlayAgain: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let goldenBananaImageView = UIImageView(image: UIImage(named: "goldenBanana"))
        goldenBananaImageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        goldenBananaImageView.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        view.addSubview(goldenBananaImageView)
        
        let messageLabel = UILabel(frame: CGRect(x: 20, y: view.center.y, width: view.bounds.width - 40, height: 100))
        messageLabel.text = "Congrats! You caught 20 bananas!\nHere is a golden banana for you!"
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 2
        view.addSubview(messageLabel)
        
        let playAgainButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        playAgainButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        playAgainButton.setTitle("Play Again", for: .normal)
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

