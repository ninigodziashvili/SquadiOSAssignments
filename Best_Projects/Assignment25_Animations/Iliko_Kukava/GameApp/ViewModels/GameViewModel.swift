//
//  GameViewModel.swift
//  GameApp
//
//  Created by iliko on 11/15/24.
//
import UIKit

class GameViewModel {
    
    // MARK: - Properties
    
    private(set) var bananaFrame: CGRect = CGRect(x: CGFloat.random(in: 0...300), y: -80, width: 80, height: 80)
    private(set) var banana2Frame: CGRect = CGRect(x: CGFloat.random(in: 0...300), y: -80, width: 80, height: 80)
    private(set) var score = 0
    private var bananaSpeed: CGFloat = 5.0
    private var diagonalSpeedX: CGFloat = 2.0
    private var diagonalSpeedY: CGFloat = 3.0
    private var banana2RotationAngle: CGFloat = 0.0
    
    var updateUI: ((CGRect, CGRect, Int, CGFloat) -> Void)?
    var notifyGameOver: (() -> Void)?
    
    // MARK: - Game Flow
    
    func startGame(viewWidth: CGFloat) {
        resetGameState()
        resetBananaState(viewWidth: viewWidth)
        resetBanana2State(viewWidth: viewWidth)
        updateUI?(bananaFrame, banana2Frame, score, banana2RotationAngle)
    }
    
    // MARK: - Handling User Interaction
    
    func handlePan(monkeyFrame: CGRect, translation: CGPoint, viewSize: CGSize) -> CGRect {
        var newFrame = monkeyFrame
        newFrame.origin.x += translation.x
        newFrame.origin.y += translation.y
        
        newFrame.origin.x = max(0, min(newFrame.origin.x, viewSize.width - newFrame.width))
        newFrame.origin.y = max(0, min(newFrame.origin.y, viewSize.height - newFrame.height))
        
        return newFrame
    }
    
    // MARK: - Game State Update
    
    func updateGameState(viewWidth: CGFloat, viewHeight: CGFloat, monkeyFrame: CGRect) {
        bananaFrame.origin.y += bananaSpeed
        if bananaFrame.origin.y > viewHeight {
            resetBananaState(viewWidth: viewWidth)
        }
        
        banana2Frame.origin.x += diagonalSpeedX
        banana2Frame.origin.y += diagonalSpeedY
        
        banana2RotationAngle += 0.05
        
        if banana2Frame.origin.x < 0 || banana2Frame.origin.x > viewWidth - banana2Frame.width {
            diagonalSpeedX = -diagonalSpeedX
        }
        
        if banana2Frame.origin.y > viewHeight {
            resetBanana2State(viewWidth: viewWidth)
        }
        
        if bananaFrame.intersects(monkeyFrame) {
            incrementScore(viewWidth: viewWidth, isBanana2: false)
        } else if banana2Frame.intersects(monkeyFrame) {
            decrementScore(viewWidth: viewWidth)
        }
        
        updateUI?(bananaFrame, banana2Frame, score, banana2RotationAngle)
    }
    
    // MARK: - Score and Banana Reset
    
    private func incrementScore(viewWidth: CGFloat, isBanana2: Bool) {
        score += 1
        if score == 20 {
            notifyGameOver?()
        } else {
            bananaSpeed += 0.5
            if isBanana2 {
                resetBanana2State(viewWidth: viewWidth)
            } else {
                resetBananaState(viewWidth: viewWidth)
            }
        }
    }
    
    private func decrementScore(viewWidth: CGFloat) {
        score -= 10
        resetBanana2State(viewWidth: viewWidth)
    }
    
    // MARK: - State Reset
    
    private func resetGameState() {
        bananaSpeed = 5.0
        score = 0
    }
    
    private func resetBananaState(viewWidth: CGFloat) {
        bananaFrame.origin = CGPoint(x: CGFloat.random(in: 0...viewWidth - bananaFrame.width), y: -bananaFrame.height)
    }
    
    private func resetBanana2State(viewWidth: CGFloat) {
        banana2Frame.origin = CGPoint(x: CGFloat.random(in: 0...viewWidth - banana2Frame.width), y: -banana2Frame.height)
        diagonalSpeedX = CGFloat.random(in: 1...2) * (Bool.random() ? 1 : -1)
        diagonalSpeedY = 3.0
        banana2RotationAngle = 0.0
    }
}

