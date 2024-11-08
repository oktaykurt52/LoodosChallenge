//
//  Extension+UIButton.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

extension UIButton {
    
    internal struct ButtonProperties {
        let title: String
        let textColor: UIColor
        let fontFamily: FontFamily
        let fontWeight: FontWeight
        let fontSize: CGFloat
        let kern: NSNumber
        let underlineStyle: NSUnderlineStyle?
        let backgroundColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor
        let cornerRadius: CGFloat
        let topPadding: CGFloat
        let leftPadding: CGFloat
        let rightPadding: CGFloat
        let bottomPadding: CGFloat
        let imagePadding: CGFloat
        let image: UIImage?
        let backgroundImage: UIImage?
        let interactionEnabled: Bool
        let contentAttribute: UISemanticContentAttribute
        let alpha: CGFloat
        
        init(title: String = "", textColor: UIColor = .clear, fontFamily: FontFamily = .SFPro, fontWeight: FontWeight = .Regular, fontSize: CGFloat = 0, kern: NSNumber = 0, underlineStyle: NSUnderlineStyle? = nil, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 0, topPadding: CGFloat = 0, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0, bottomPadding: CGFloat = 0, imagePadding: CGFloat = 0, image: UIImage? = nil, backgroundImage: UIImage? = nil, interactionEnabled: Bool = true, contentAttribute: UISemanticContentAttribute = .forceLeftToRight, alpha: CGFloat = 1.0) {
            self.title = title
            self.textColor = textColor
            self.fontFamily = fontFamily
            self.fontWeight = fontWeight
            self.fontSize = fontSize
            self.kern = kern
            self.underlineStyle = underlineStyle
            self.backgroundColor = backgroundColor
            self.borderWidth = borderWidth
            self.borderColor = borderColor
            self.cornerRadius = cornerRadius
            self.topPadding = topPadding
            self.leftPadding = leftPadding
            self.rightPadding = rightPadding
            self.bottomPadding = bottomPadding
            self.imagePadding = imagePadding
            self.image = image
            self.backgroundImage = backgroundImage
            self.interactionEnabled = interactionEnabled
            self.contentAttribute = contentAttribute
            self.alpha = alpha
        }
    }
    
    func createButton(properties: ButtonProperties) {
        DispatchQueue.main.async {
            self.alpha = properties.alpha
            self.titleLabel?.numberOfLines = 0
            self.titleLabel?.textAlignment = .center
            self.layer.backgroundColor = properties.backgroundColor.cgColor
            self.layer.cornerRadius = properties.cornerRadius
            self.layer.borderWidth = properties.borderWidth
            self.layer.borderColor = properties.borderColor.cgColor
            
            let fontGenerator = FontGenerator()
            
            var attributes: [NSMutableAttributedString.Key: Any] = [
                .foregroundColor: properties.textColor,
                .font: fontGenerator.generateFont(family: properties.fontFamily, weight: properties.fontWeight, size: properties.fontSize),
                .kern: properties.kern
            ]
            
            if let underline = properties.underlineStyle {
                attributes[.underlineStyle] = underline.rawValue
                attributes[.underlineColor] = properties.textColor
            }
            
            let title = NSMutableAttributedString(string: properties.title, attributes: attributes)
            
            UIView.performWithoutAnimation {
                self.setAttributedTitle(title, for: .normal)
                self.layoutIfNeeded()
            }
            self.setImage(properties.image, for: .normal)
            self.setBackgroundImage(properties.backgroundImage, for: .normal)
            self.semanticContentAttribute = properties.contentAttribute
            
            if #available(iOS 15.0, *) {
                var config = UIButton.Configuration.plain()
                config.contentInsets = .init(top: properties.topPadding, leading: properties.leftPadding, bottom: properties.bottomPadding, trailing: properties.rightPadding)
                config.imagePadding = properties.imagePadding
                self.configuration = config
            } else {
                self.contentEdgeInsets = UIEdgeInsets(top: properties.topPadding, left: properties.leftPadding, bottom: properties.bottomPadding, right: properties.rightPadding)
                switch properties.contentAttribute {
                case .forceLeftToRight:
                    self.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: properties.imagePadding)
                case .forceRightToLeft:
                    self.imageEdgeInsets = .init(top: 0, left: properties.imagePadding, bottom: 0, right: 0)
                default:
                    break
                }
            }
            
            self.isUserInteractionEnabled = properties.interactionEnabled
        }
    }
}
