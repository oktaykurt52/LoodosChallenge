//
//  FontGenerator.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class FontGenerator {
    /// Generate custom font family with expected size. Returns system font if custom font is not found.
    func generateFont(family: FontFamily, weight: FontWeight, size: CGFloat) -> UIFont {
        return UIFont(name: "\(family.rawValue)-\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
