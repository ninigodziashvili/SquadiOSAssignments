

import UIKit

final class GameViewModel {
    
    private var gameModel = GameModel()
    private var displayLink: CADisplayLink?
    
    var scoreUpdated: ((Int) -> Void)?
    var gameOver: (() -> Void)?
    var ballPositionUpdated: ((CGPoint) -> Void)?
    
    var characterFrame = CGRect.zero
    
    func resetBallPosition(viewWidth: CGFloat, basketballViewWidth: CGFloat) {
        self.gameModel.ballPosition = CGPoint(x: CGFloat.random(in: 0...(viewWidth - basketballViewWidth)), y: 0)
        ballPositionUpdated?(gameModel.ballPosition)
        gameModel.ballSpeed += 1
    }
    
    func startBallFall() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateBallPosition))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc func updateBallPosition() {
        guard gameModel.score < 20 else { return }

        gameModel.ballPosition.y += gameModel.ballSpeed
        ballPositionUpdated?(gameModel.ballPosition)
        checkForCollision(characterFrame: characterFrame)
        
        if gameModel.ballPosition.y > UIScreen.main.bounds.height {
            resetBallPosition(viewWidth: UIScreen.main.bounds.width, basketballViewWidth: 100)
        }
    }

    func checkForCollision(characterFrame: CGRect) {
        let ballRect = CGRect(x: gameModel.ballPosition.x, y: gameModel.ballPosition.y, width: 100, height: 100)
        
        if ballRect.intersects(characterFrame) {
            gameModel.isBallColliding = true
            gameModel.score += 1
            scoreUpdated?(gameModel.score)
  
            if gameModel.score == 20 {
                gameOver?()
                stopBallFall()
            } else {
                resetBallPosition(viewWidth: UIScreen.main.bounds.width, basketballViewWidth: 100)
            }
        }
    }
    
    func restart() {
        stopBallFall()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.gameModel.ballSpeed = 5
            self?.gameModel.score = 0
            self?.startBallFall()
        }
    }
    
    func stopBallFall() {
        displayLink?.invalidate()
        displayLink = nil
    }
}
