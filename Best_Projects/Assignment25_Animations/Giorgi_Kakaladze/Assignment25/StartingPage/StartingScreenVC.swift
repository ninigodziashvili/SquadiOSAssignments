//
//  StartingScreenVC.swift
//  Assignment25
//
//  Created by Gio Kakaladze on 15.11.24.
//

import UIKit

class StartingScreenVC: UIViewController {

    let jungleBackground: UIImageView = {
        let jungleBackground = UIImageView()
        jungleBackground.image = UIImage(named: "jungle")
        jungleBackground.contentMode = .scaleAspectFill
        jungleBackground.translatesAutoresizingMaskIntoConstraints = false
        return jungleBackground
    }()

    let monkeyImage: UIImageView = {
        let monkeyImage = UIImageView()
        monkeyImage.image = UIImage(named: "monkey")
        monkeyImage.contentMode = .scaleAspectFit
        monkeyImage.translatesAutoresizingMaskIntoConstraints = false
        return monkeyImage
    }()

    let bananaImage: UIImageView = {
        let bananaImage = UIImageView()
        bananaImage.image = UIImage(named: "banana")
        bananaImage.contentMode = .scaleAspectFit
        bananaImage.translatesAutoresizingMaskIntoConstraints = false
        return bananaImage
    }()

    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PLAY", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        setupView()
        setupPlayButton()
    }

    private func setupView() {
        view.addSubview(jungleBackground)
        view.addSubview(monkeyImage)
        view.addSubview(bananaImage)

        NSLayoutConstraint.activate([
            jungleBackground.topAnchor.constraint(equalTo: view.topAnchor),
            jungleBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            jungleBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            jungleBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
    
            monkeyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monkeyImage.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            monkeyImage.widthAnchor.constraint(equalToConstant: 150),
            monkeyImage.heightAnchor.constraint(equalToConstant: 150),

            bananaImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bananaImage.bottomAnchor.constraint(equalTo: monkeyImage.topAnchor, constant: -50),
            bananaImage.widthAnchor.constraint(equalToConstant: 80),
            bananaImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupPlayButton() {
        view.addSubview(playButton)
        
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func playButtonTapped() {
        let MainVC = MainGameVC()
        navigationController?.pushViewController(MainVC, animated: true)
    }
}
