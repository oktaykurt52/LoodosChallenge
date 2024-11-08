//
//  HomeViewModel.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import SnapKit

class HomeViewModel {
    
    internal enum KeyboardStatus {
        case willShow
        case willHide
    }
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .homeBackground
        return imageView
    }()
    
    lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.createTitle(customizableText: .init(text: "Movies", textColor: .init(color: .viewTitle), fontFamily: .DrukTextWide, fontWeight: .Bold, fontSize: 28, kern: -0.5))
        return label
    }()
    
    lazy var bottomSearchView: UIView = {
        let view = UIView()
        view.createView(properties: .init(backgroundColor: .init(color: .searchBarBackground), cornerRadius: 40))
        return view
    }()
    
    lazy var movieTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Search movies..."
        textField.font = FontGenerator().generateFont(family: .SFPro, weight: .Regular, size: 20)
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.createButton(properties: .init(backgroundColor: .init(color: .splashTitle), cornerRadius: 20, image: .homeSearchIcon))
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCells(cells: [
            .init(cellClass: MovieCollectionViewCell.self, reuseIdentifier: CellIds.MovieCollectionViewCell.rawValue)
        ])
        collectionView.backgroundColor = .clear
        collectionView.delegate = movieDataSource
        collectionView.dataSource = movieDataSource
        return collectionView
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .init(color: .viewTitle)
        activity.style = .large
        activity.hidesWhenStopped = true
        return activity
    }()
    
    lazy var emptyResultText: UILabel = {
        let label = UILabel()
        label.createTitle(customizableText: .init(text: "No Results", textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Bold, fontSize: 20))
        return label
    }()
    
    lazy var emptyResultIcon: UIImageView = {
        let imageView = UIImageView(image: .homeEmptyIcon)
        return imageView
    }()
    
    lazy var emptyResultStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            emptyResultText, emptyResultIcon
        ])
        stack.alpha = 0.3
        stack.isHidden = true
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    weak var homeView: HomeViewController?
    let movieDataSource = MovieDataSource()
    
    func setupRoot(on viewController: HomeViewController) {
        homeView = viewController
        viewController.view.backgroundColor = .init(color: .background)
        viewController.view.addSubview(backgroundImage)
        viewController.view.addSubview(viewTitle)
        viewController.view.addSubview(bottomSearchView)
        bottomSearchView.addSubview(searchButton)
        bottomSearchView.addSubview(movieTextField)
        viewController.view.addSubview(emptyResultStack)
        viewController.view.addSubview(collectionView)
        viewController.view.addSubview(activity)
        //...
        backgroundImage.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
        }
        viewTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(63)
        }
        bottomSearchView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.left.bottom.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 40, right: 10))
        }
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(25)
        }
        movieTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(30)
            $0.right.equalTo(searchButton.snp.left).inset(-30)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(viewTitle.snp.bottom).inset(-30)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(bottomSearchView.snp.top)
        }
        activity.snp.makeConstraints {
            $0.center.equalTo(collectionView.snp.center)
        }
        emptyResultStack.snp.makeConstraints {
            $0.center.equalTo(collectionView.snp.center)
        }
        notificationCenter.addObserver(forName: .keyboardWillAppear, object: nil, queue: .main) { [weak self] notification in
            guard let self = self else { return }
            self.backgroundImage.changeVisibility(alpha: 0, animated: true)
            self.updateKeyboardUI(for: .willShow, with: notification)
        }
        notificationCenter.addObserver(forName: .keyboardWillHide, object: nil, queue: .main) { [weak self] notification in
            guard let self = self else { return }
            movieDataSource.bindedMovies == nil ? self.backgroundImage.changeVisibility(alpha: 1, animated: true): nil
            emptyResultStack.isHidden = true
            self.updateKeyboardUI(for: .willHide, with: notification)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = true
        viewController.view.addGestureRecognizer(tapGesture)
    }
    
    func onDidLayoutTasks() {
        bottomSearchView.addGradientBorder(name: "bottomSearchView", width: 1, colors: [
            .init(color: .searchBarTop), .init(color: .searchBarBottom)
        ], startPoint: .topCenter, endPoint: .bottomCenter, cornerRadius: 40)
    }
    
    private func updateKeyboardUI(for status: KeyboardStatus, with notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        let padding: CGFloat = status == .willHide ? 40: (keyboardHeight + 10)
        bottomSearchView.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: padding, right: 0))
        }
        UIView.animate(withDuration: 0.5) {
            self.homeView?.view.layoutIfNeeded()
        }
    }
    
    @objc private func viewTapped() {
        movieTextField.endEditing(true)
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        guard movieTextField.text != "" else {
            return
        }
        let movieService = MovieService()
        Task { @MainActor in
            do {
                activity.startAnimating()
                emptyResultStack.isHidden = true
                let search = try await movieService.fetchMovies(with: movieTextField.text ?? "")
                let fetchedMovies = search.movies
                emptyResultStack.isHidden = fetchedMovies != nil
                movieDataSource.bindedMovies = fetchedMovies
                collectionView.reloadThreadSafe()
                activity.stopAnimating()
            } catch {
                activity.stopAnimating()
                homeView?.showAlert(title: "Something went wrong", message: "Please make sure you have an internet connection and try again.", actionTitle: "Ok", completion: { _ in })
            }
        }
    }
}
