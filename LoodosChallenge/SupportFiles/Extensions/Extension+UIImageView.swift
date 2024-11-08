//
//  Extension+UIImageView.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageWithUrl(url: String, completion: @escaping (_ isDone: Bool) -> Void) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: nil, options: .scaleDownLargeImages) { image, error, cacheType, url in
            completion(true)
        }
    }
}
