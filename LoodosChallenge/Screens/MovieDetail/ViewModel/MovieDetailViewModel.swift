//
//  MovieDetailViewModel.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import SnapKit

class MovieDetailViewModel {
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.createButton(properties: .init(backgroundColor: .init(color: .background), cornerRadius: 15, image: .movideDetailDismissIcon))
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(dismissButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .init(color: .viewTitle)
        activity.style = .large
        activity.hidesWhenStopped = true
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerCells(cells: [
            .init(cellClass: MoviePosterTableViewCell.self, reuseIdentifier: CellIds.MoviePosterTableViewCell.rawValue),
            .init(cellClass: MovieInfoTableViewCell.self, reuseIdentifier: CellIds.MovieInfoTableViewCell.rawValue),
            .init(cellClass: MovieManageTableViewCell.self, reuseIdentifier: CellIds.MovieManageTableViewCell.rawValue),
            .init(cellClass: MoviePlotTableViewCell.self, reuseIdentifier: CellIds.MoviePlotTableViewCell.rawValue),
            .init(cellClass: MovieCastTableViewCell.self, reuseIdentifier: CellIds.MovieCastTableViewCell.rawValue),
        ])
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: 170, right: 0)
        tableView.delegate = movieDataSource
        tableView.dataSource = movieDataSource
        return tableView
    }()
    
    let movieDataSource = MovieDetailDataSource()
    var bindedMovie: Movie?
    weak var movideDetailView: MovieDetailViewController?
    
    func setupRoot(on viewController: MovieDetailViewController) {
        self.movideDetailView = viewController
        viewController.view.backgroundColor = .init(color: .background)
        viewController.view.addSubview(tableView)
        viewController.view.addSubview(dismissButton)
        viewController.view.addSubview(activity)
        //...
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dismissButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12))
            $0.top.equalTo(viewController.view.safeAreaLayoutGuide.snp.top).inset(12)
        }
        activity.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func onWillAppearTasks() {
        guard let movie = bindedMovie else { return }
        let firebaseService = FirebaseService(analyticsService: .init())
        let movieService = MovieService()
        Task { @MainActor in
            do {
                let movieDetail = try await movieService.fetchMovieDetail(with: movie)
                firebaseService.analyticsService?.logEvent(with: "MovieLogs", optionalParameters: [
                    "Movie_title": movieDetail.title ?? "",
                    "Movie_genre": movieDetail.genre ?? "",
                    "IMDb_id": movieDetail.imdbID ?? "",
                    "IMDb_rate": movieDetail.imdbRating ?? "",
                    "IMDb_vote_count": movieDetail.imdbVotes ?? ""
                ])
                movieDataSource.bindedMovieDetail = movieDetail
                tableView.reloadThreadSafe()
            } catch let error {
                print("Error while fetching movie detail: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func dismissButtonTapped(sender: UIButton) {
        movideDetailView?.dismiss(animated: true)
    }
}
