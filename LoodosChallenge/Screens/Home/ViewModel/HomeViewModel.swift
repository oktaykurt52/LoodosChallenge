//
//  HomeViewModel.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import SnapKit

class HomeViewModel {
    
    weak var homeView: HomeViewController?
    
    func setupRoot(on viewController: HomeViewController) {
        homeView = viewController
        viewController.view.backgroundColor = .init(color: .background)
    }
}
