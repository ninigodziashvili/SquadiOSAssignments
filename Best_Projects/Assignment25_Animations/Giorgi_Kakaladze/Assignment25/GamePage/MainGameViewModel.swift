//
//  MainGameViewModel.swift
//  Assignment25
//
//  Created by Gio Kakaladze on 15.11.24.
//

import UIKit

class MainGameViewModel {
    
    private(set) var score = 0 {
        didSet {
            updateScoreHandler?("Score: \(score)")
        }
    }
    
    private(set) var bananaSpeed: Double = 4.0
    private(set) var isGameOver = false
    private let maxBananaSpeed: Double = 35.0
    private let maxScore = 100

    var updateScoreHandler: ((String) -> Void)?
    var showAlertHandler: ((String) -> Void)?
    var resetBananaPositionHandler: (() -> CGPoint)?

    func incrementScore() {
        score += 1
        if score >= maxScore {
            isGameOver = true
            showAlertHandler?("საკმარისია! თქვენ დააგროვეთ \(maxScore) ქულა!")
            score = maxScore
        }
    }

    func updateBananaFall(bananaFrame: CGRect, viewHeight: CGFloat) -> Bool {
        if bananaFrame.origin.y > viewHeight {
            isGameOver = true
            showAlertHandler?("სამწუხაროდ წააგეთ 😭")
            return true
        }
        return false
    }

    func checkForCollision(monkeyFrame: CGRect, bananaFrame: CGRect) -> Bool {
        if monkeyFrame.intersects(bananaFrame) {
            incrementScore()
            if !isGameOver {
                bananaSpeed = min(bananaSpeed + 0.5, maxBananaSpeed)
                _ = resetBananaPositionHandler?()
            }
            return true
        }
        return false
    }

    func resetGame() {
        score = 0
        bananaSpeed = 4.0
        isGameOver = false
        _ = resetBananaPositionHandler?()
    }
}
