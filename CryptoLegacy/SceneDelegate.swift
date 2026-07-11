import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            print("[CryptoLegacy] openURLContexts called but no URL")
            return
        }
        print("[CryptoLegacy] Received URL: \(url.absoluteString)")
        print("[CryptoLegacy] scheme=\(url.scheme ?? "nil") host=\(url.host ?? "nil")")
        
        if url.scheme == "cryptomator-legacy", url.host == "upgrade" {
            let targetURL = URL(string: "cryptomator://purchase")!
            print("[CryptoLegacy] Opening: \(targetURL.absoluteString)")
            
            UIApplication.shared.open(targetURL, options: [:]) { success in
                print("[CryptoLegacy] open() completed, success=\(success)")
            }
        }
    }
}
