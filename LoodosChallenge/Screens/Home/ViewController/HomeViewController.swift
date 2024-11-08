//
//  HomeViewController.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - UI Elements
    
    // MARK: - Stored Properties
    let viewModel = HomeViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.onDidLayoutTasks()
    }
    
    // MARK: - Functions
    func setupView() {
        viewModel.setupRoot(on: self)
    }
    
    // MARK: - Actions
    
    // MARK: - Extensions
}
