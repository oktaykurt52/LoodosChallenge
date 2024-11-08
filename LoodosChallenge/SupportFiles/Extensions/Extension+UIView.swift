//
//  Extension+UIView.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

extension UIView {
    
    internal struct Properties {
        let backgroundColor: UIColor
        let cornerRadius: CGFloat
        let maskedCorners: CACornerMask
        let clipsToBounds: Bool
        
        init(backgroundColor: UIColor = .clear, cornerRadius: CGFloat = 0, maskedCorners: CACornerMask = [.topLeft, .topRight, .bottomLeft, .bottomRight], clipsToBounds: Bool = true) {
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.maskedCorners = maskedCorners
            self.clipsToBounds = clipsToBounds
        }
    }
    
    func createView(properties: Properties) {
        self.backgroundColor = properties.backgroundColor
        self.layer.cornerRadius = properties.cornerRadius
        self.layer.maskedCorners = properties.maskedCorners
        self.clipsToBounds = properties.clipsToBounds
    }
    
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
    
    func addGradientBorder(name: String = "", width: CGFloat, colors: [UIColor], startPoint: CGPoint = .centerLeft, endPoint: CGPoint = .centerRight, cornerRadius: CGFloat = 0, toIndex: UInt32 = 0, opacity: Float = 1.0) {
        DispatchQueue.main.async {
            let currentLayer = self.layer.sublayers?.filter({$0.isKind(of: CAGradientLayer.self) && $0.name == name})
            currentLayer?.forEach({ layer in
                layer.removeFromSuperlayer()
            })
            
            let existingBorder = self.gradientBorderLayer(name: name)
            let border = existingBorder ?? .init()
            border.name = name
            border.frame = CGRect(
                x: self.bounds.origin.x,
                y: self.bounds.origin.y,
                width: self.bounds.size.width + width,
                height: self.bounds.size.height + width
            )
            border.colors = colors.map { $0.cgColor }
            border.startPoint = startPoint
            border.endPoint = endPoint
            
            let mask = CAShapeLayer()
            let maskRect = CGRect(
                x: self.bounds.origin.x + width/2,
                y: self.bounds.origin.y + width/2,
                width: self.bounds.size.width - width,
                height: self.bounds.size.height - width
            )
            mask.path = UIBezierPath(
                roundedRect: maskRect,
                cornerRadius: cornerRadius
            ).cgPath
            mask.fillColor = UIColor.clear.cgColor
            mask.strokeColor = UIColor.white.cgColor
            mask.lineWidth = width
            
            border.mask = mask
            border.opacity = opacity
            
            let isAlreadyAdded = (existingBorder != nil)
            if !isAlreadyAdded {
                self.layer.insertSublayer(border, at: toIndex)
            }
        }
    }
    
    private func gradientBorderLayer(name: String) -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter {
            $0.name == name
        }
        if borderLayers?.count ?? 0 > 1 {
            fatalError()
        }
        return borderLayers?.first as? CAGradientLayer
    }
}
