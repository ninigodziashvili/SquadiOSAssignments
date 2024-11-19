import UIKit


final class GameModel {
    var score: Int = 0
    var ballPosition: CGPoint = .zero
    var ballSpeed: CGFloat = 5.0
    var isBallColliding: Bool = false
}
