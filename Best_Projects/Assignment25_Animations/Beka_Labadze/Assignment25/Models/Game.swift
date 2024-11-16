//
//  Game.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class GameModel {
    var score: Int = 0
    var bananaSpeed: CGFloat = 2.0
    var gameOver: Bool = false

    func increaseScore() {
        score += 1
        if score % 5 == 0 {
            bananaSpeed += 4
        }
    }

    func checkGameOver() -> Bool {
        return score == 20
    }
}
