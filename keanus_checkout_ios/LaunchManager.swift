//
//  LaunchManager.swift
//  Keanu's Checkout
//
//  Created by Max Chan on 5/30/22.
//

import UIKit

class LaunchManager {
    static let shared = LaunchManager()
    init() {}
    
    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    func launched(with options: [UIApplication.LaunchOptionsKey: Any]?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(
            rootViewController: SetupScannerVC()
        )
    }
}
