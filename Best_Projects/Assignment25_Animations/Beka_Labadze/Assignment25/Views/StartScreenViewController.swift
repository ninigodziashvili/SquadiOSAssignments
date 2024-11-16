//
//  StartScreenViewController.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class StartViewController: UIViewController {
    private var viewModel: StartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let startButton = UIButton(type: .system)
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        viewModel = StartViewModel()
        viewModel.onGameStart = { [weak self] in
            self?.startGame()
        }
    }

    @objc func startGame() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
}
