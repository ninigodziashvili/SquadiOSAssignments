//
//  GameViewModel.swift
//  AnimationTest
//
//  Created by Imac on 15.11.24.
//

import UIKit

class GameViewModel {
    var model = GameModel()
    var scoreText: String {
        "Score: \(model.gameScore)"
    }
    
    func catchBanana() {
        model.increaseScore(by: 1)
    }
    
    func catchSpecialBanana() {
        model.increaseScore(by: 5)
    }

    func catchEvilBanana(completion: @escaping () -> Void) {
        model.increaseScore(by: 5)
        let originalSpeed = model.bananaSpeed
        model.bananaSpeed = 5
        DispatchQueue.main.asyncAfter(deadline: .now() + model.slowBananaDuration) { [weak self] in
            self?.model.bananaSpeed = originalSpeed
            completion()
        }
    }
    
    func resetGame(completion: () -> Void) {
        model.resetGame()
        completion()
    }
}
