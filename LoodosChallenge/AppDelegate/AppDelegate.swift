//
//  AppDelegate.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFirebase()
        setRootViewController()
        return true
    }
    
    fileprivate func setRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.overrideUserInterfaceStyle = .dark
        let splashView: UIViewController = .createSlash()
        self.window?.rootViewController = splashView
        self.window?.makeKeyAndVisible()
    }
    
    fileprivate func setupFirebase() {
        FirebaseApp.configure()
    }
}
