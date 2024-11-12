//
//  SceneDelegate.swift
//  Assignment19
//
//  Created by Beka on 30.10.24.
//

import UIKit
import MainApp1

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        let navigationController =  UINavigationController(rootViewController:NewsListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
