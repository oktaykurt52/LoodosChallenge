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
        pushNotificationRequest(application)
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
    
    fileprivate func pushNotificationRequest(_ application: UIApplication) {
        Messaging.messaging().delegate = self
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = UIApplication.shared.delegate as? AppDelegate
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        notificationCenter.requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        )
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Did receive token:", deviceToken)
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("APNS token:", fcmToken ?? "")
    }
}
