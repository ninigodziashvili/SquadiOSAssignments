//
//  SceneDelegate.swift
//  Assignment25
//
//  Created by Beka on 15.11.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let startViewController = StartViewController()
        let navigationController = UINavigationController(rootViewController: startViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
