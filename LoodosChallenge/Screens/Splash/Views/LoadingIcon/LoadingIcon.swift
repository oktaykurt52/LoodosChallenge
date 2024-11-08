//
//  LoadingIcon.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class LoadingIcon: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.alpha = 0.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.alpha = 1.0
            self.addRotateAnimation(animName: "LoadingIcon", duration: 0.75)
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.alpha = 0
            self.removeAnimation(animName: "LoadingIcon")
        }
    }
}
