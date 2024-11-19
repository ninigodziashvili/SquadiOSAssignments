//
//  GameModel.swift
//  AnimationTest
//
//  Created by Imac on 15.11.24.
//

import UIKit

struct GameModel {
    var gameScore = 0
    var bananaSpeed: CGFloat = 10
    var specialBananaSpeed: CGFloat = 8
    var evilBananaSpeed: CGFloat = 6
    var isGameOver = false
    var specialBananaActive = false
    var evilBananaActive = false
    let slowBananaDuration: TimeInterval = 1.5

    mutating func increaseScore(by points: Int) {
        gameScore += points
    }
    
    mutating func resetGame() {
        gameScore = 0
        bananaSpeed = 10
        specialBananaSpeed = 8
        evilBananaSpeed = 6
        isGameOver = false
    }
}
