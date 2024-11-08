//
//  Extension+UIView.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

extension UIView {
    
    func changeVisibility(alpha: CGFloat, animated: Bool = false) {
        if animated {
            UIView.animate(withDuration: 0.25) { // Fix duration
                self.alpha = alpha
            }
        } else {
            self.alpha = alpha
        }
    }
    func addRotateAnimation(animName: String, duration: CFTimeInterval = 2.0) {
        self.removeAnimation(animName: animName)
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotateAnimation, forKey: animName)
    }
    
    func removeAnimation(animName: String) {
        self.layer.removeAnimation(forKey: animName)
    }
}
