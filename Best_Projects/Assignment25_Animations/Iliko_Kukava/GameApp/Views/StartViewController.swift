//
//  StartViewController.swift
//  GameApp
//
//  Created by iliko on 11/15/24.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Properties
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .medium)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStartButton()
    }
    
    // MARK: - UI Setup
    
    func setupStartButton() {
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        startButton.addAction(UIAction(handler: { [weak self] _ in
            self?.startGame()
        }), for: .touchUpInside)
    }
    
    // MARK: - Game Logic
    
    func startGame() {
        let gameController = GameViewController()
        gameController.modalPresentationStyle = .fullScreen
        gameController.modalTransitionStyle = .coverVertical
        present(gameController, animated: true, completion: nil)
    }
}
