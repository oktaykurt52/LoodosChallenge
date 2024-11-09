//
//  MovieDetailViewController.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - UI Elements
    
    // MARK: - Stored Properties
    let viewModel = MovieDetailViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onWillAppearTasks()
    }
    
    // MARK: - Functions
    func setupView() {
        viewModel.setupRoot(on: self)
    }
    
    // MARK: - Actions
    
    // MARK: - Extensions
}
