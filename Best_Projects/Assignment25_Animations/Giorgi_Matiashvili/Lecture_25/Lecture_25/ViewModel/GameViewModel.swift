//
//  GameViewModel.swift
//  Lecture_25
//
//  Created by Giorgi Matiashvili on 15.11.24.
//

import Foundation

class GameViewModel {
    private(set) var model = GameModel()
    var onScoreUpdate: ((Int) -> Void)?
    var onGameOver: (() -> Void)?

    func catchBanana() {
        model.bananasCaught += 1
        onScoreUpdate?(model.bananasCaught)
    }

    func missBanana() {
        model.bananasMissed += 1
        if model.bananasMissed > 0 {
            model.isGameOver = true
            onGameOver?()
        }
    }

    func resetGame() {
        model = GameModel()
    }
}
