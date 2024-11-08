//
//  Extension+UIViewController.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

extension UIViewController {
    
    internal enum AlertActionType {
        case tryAgain
    }
    /// For deiniting views that not needed anymore in navigation stack. Modally presented controllers automaticly deinited
    func deinitSelf() {
        self.navigationController?.viewControllers.removeAll(where: {$0 == self})
    }
    
    static func createSlash() -> UINavigationController {
        let splashView = SplashViewController()
        let navigation = UINavigationController(rootViewController: splashView)
        navigation.setNavigationBarHidden(true, animated: false)
        return navigation
    }
    
    func pushHome() {
        DispatchQueue.main.async {
            guard let navigation = self.navigationController else { return }
            let homeView = HomeViewController()
            navigation.pushViewController(homeView, animated: true)
        }
    }
    
    typealias alertActionTypeEnum = (_ type: AlertActionType) -> ()
    func showAlert(title: String? = nil, message: String? = nil, actionTitle: String? = nil, completion: @escaping alertActionTypeEnum) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let tryAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                completion(.tryAgain) // Try again handler for restarting flow
            }
            alert.addAction(tryAction)
            self.present(alert, animated: true)
        }
    }
    
    func dismissAlert() {
        DispatchQueue.main.async {
            let alert = self.presentedViewController as? UIAlertController
            alert?.dismiss(animated: true)
        }
    }
}
