//
//  StartViewModel.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import Foundation

class StartViewModel {
    
    var onGameStart: (() -> Void)?
    
    func startGame() {
        onGameStart?()
    }
}
