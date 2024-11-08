//
//  SplashViewController.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class SplashViewController: UIViewController {
    // MARK: - UI Elements
    
    // MARK: - Stored Properties
    let viewModel = SplashViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onDidDisappearTasks()
    }
    
    // MARK: - Functions
    func setupView() {
        viewModel.setupRoot(on: self)
    }
    
    // MARK: - Actions
    
    // MARK: - Extensions
}
