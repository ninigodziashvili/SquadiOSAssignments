import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let savedUsername = UserDefaults.standard.string(forKey: "username")
        var rootViewController: UIViewController
        
        if let username = savedUsername, !username.isEmpty {
            if let _ = KeyChainManager.get(service: "Quiz.app", account: username) {
                rootViewController = QuestionsListPageVC()
            } else {
                rootViewController = LoginPageVC()
            }
        } else {
            rootViewController = LoginPageVC()
        }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
}
