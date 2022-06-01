//
//  AppDelegate.swift
//  keanus_checkout_ios
//
//  Created by Max Chan on 5/30/22.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LaunchManager.shared.launched(with: launchOptions)
        setupIntegrations()
        return true
    }
    
    private func setupIntegrations() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

