//
//  Extension+UILabel.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Foundation
import UIKit

extension UILabel {
    
    internal struct CustomizableText {
        var text: String
        var backgroundColor: UIColor
        var numberOfLines: Int
        var alignment: NSTextAlignment
        var radius: CGFloat
        var textColor: UIColor
        var fontFamily: FontFamily
        var fontWeight: FontWeight
        var fontSize: CGFloat
        var kern: NSNumber
        var lineBreakMode: NSLineBreakMode
        var strikeColor: UIColor
        var adjustFont: Bool
        
        init(text: String = "", backgroundColor: UIColor = .clear, numberOfLines: Int = 0, alignment: NSTextAlignment = .center, radius: CGFloat = 0, textColor: UIColor = .clear, fontFamily: FontFamily = .SFPro, fontWeight: FontWeight = .Bold, fontSize: CGFloat = 0, kern: NSNumber = 0, strikeColor: UIColor = .clear, adjustFont: Bool = false, lineBreakMode: NSLineBreakMode = .byWordWrapping) {
            self.text = text
            self.backgroundColor = backgroundColor
            self.numberOfLines = numberOfLines
            self.alignment = alignment
            self.radius = radius
            self.textColor = textColor
            self.fontFamily = fontFamily
            self.fontWeight = fontWeight
            self.fontSize = fontSize
            self.kern = kern
            self.strikeColor = strikeColor
            self.adjustFont = adjustFont
            self.lineBreakMode = lineBreakMode
        }
    }
    
    func createTitle(customizableText: CustomizableText) {
        let attributedText = NSMutableAttributedString()
        self.numberOfLines = customizableText.numberOfLines
        self.backgroundColor = customizableText.backgroundColor
        self.layer.cornerRadius = customizableText.radius
        
        let fontGenerator = FontGenerator()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = customizableText.alignment
        paragraphStyle.lineBreakMode = customizableText.lineBreakMode
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: customizableText.textColor,
            .font: fontGenerator.generateFont(family: customizableText.fontFamily, weight: customizableText.fontWeight, size: customizableText.fontSize),
            .kern: customizableText.kern,
            .strikethroughColor: customizableText.strikeColor,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let text = NSMutableAttributedString(string: customizableText.text, attributes: attributes)
        attributedText.append(text)
        self.adjustsFontSizeToFitWidth = customizableText.adjustFont
        
        DispatchQueue.main.async {
            self.attributedText = attributedText
        }
    }
}
