//
//  Extension+UIColor.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

extension UIColor {
    /// Creates a 'UIColor' object from given hex string and alpha parameters
    convenience init(color: Colors, alpha: CGFloat = 1.0) {
        let hexString: String = color.rawValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = hexString.index(hexString.startIndex, offsetBy: 1)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    internal enum Colors: String {
        // Gradients
        case searchBarTop = "#2A2A2A"
        case searchBarBottom = "#151515"
        // Defaults
        case background = "#000000"
        case splashTitle = "#E50000"
        case viewTitle = "#FFFFFF"
        case searchBarBackground = "#1E1E1E"
    }
    
    static var randomColor: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
