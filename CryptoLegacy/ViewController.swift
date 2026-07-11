import UIKit
import Security

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Cryptomator Legacy"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Keychain 쓰기
        writeUpgradeFlag()
        print("[CryptoLegacy] Keychain flag written")
    }
    
    private func writeUpgradeFlag() {
        var eligible = true
        let data = Data(bytes: &eligible, count: MemoryLayout<Bool>.size)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "org.cryptomator.ios.upgrade",
            kSecAttrAccount as String: "eligibleForUpgrade",
            kSecValueData as String: data,
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        print("[CryptoLegacy] Keychain write status: \(status)")
    }
}
