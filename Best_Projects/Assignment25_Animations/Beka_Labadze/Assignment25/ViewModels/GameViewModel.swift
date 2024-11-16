//
//  GameViewModel.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class GameViewModel {
    private var gameModel: GameModel
    var monkey: UIImageView
    private var fallingBananas: [UIImageView] = []

    var onScoreUpdated: ((Int) -> Void)?
    var onGameOver: (() -> Void)?
    var onBananaAdded: ((UIImageView) -> Void)?

    init(monkey: UIImageView, gameModel: GameModel) {
        self.monkey = monkey
        self.gameModel = gameModel
    }

    func moveMonkey(to position: CGPoint) {
        monkey.center = position
    }

    func spawnBanana(view: UIView) {
        let banana = UIImageView(image: UIImage(named: "banana"))
        banana.frame = CGRect(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width - 50), y: -50, width: 50, height: 50)
        fallingBananas.append(banana)
        view.addSubview(banana)
    }

    func updateGame() {
        for banana in fallingBananas {
            banana.frame.origin.y += gameModel.bananaSpeed
            if banana.frame.origin.y > UIScreen.main.bounds.height {
                banana.removeFromSuperview()
                fallingBananas.removeAll { $0 == banana }
            }

            if monkey.frame.intersects(banana.frame) {
                banana.removeFromSuperview()
                fallingBananas.removeAll { $0 == banana }
                gameModel.increaseScore()
                onScoreUpdated?(gameModel.score)

                if gameModel.checkGameOver() {
                    onGameOver?()
                }
            }
        }
    }
}
