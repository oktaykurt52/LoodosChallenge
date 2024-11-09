//
//  MovieDetailDataSource.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class MovieDetailDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var movieSections = MovieDetailSection.createAll
    var bindedMovieDetail: MovieDetail?
    
    var sectionCount: Int {
        return bindedMovieDetail == nil ? 0: movieSections.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSections[section].itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = movieSections[indexPath.section]
        switch section.type {
        case .moviePoster:
            guard let posterCell = tableView.dequeueReusableCell(withIdentifier: CellIds.MoviePosterTableViewCell.rawValue, for: indexPath) as? MoviePosterTableViewCell else { return .init() }
            posterCell.prepareForDrawing(with: bindedMovieDetail)
            return posterCell
        case .info:
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: CellIds.MovieInfoTableViewCell.rawValue, for: indexPath) as? MovieInfoTableViewCell else { return .init() }
            infoCell.prepareForDrawing(with: bindedMovieDetail)
            return infoCell
        case .manageMedia:
            guard let manageCell = tableView.dequeueReusableCell(withIdentifier: CellIds.MovieManageTableViewCell.rawValue, for: indexPath) as? MovieManageTableViewCell else { return .init() }
            let manageItem = movieSections[indexPath.section].mediaManageItems[indexPath.row]
            manageCell.prepareForDrawing(with: manageItem, for: bindedMovieDetail)
            return manageCell
        case .plot:
            guard let plotCell = tableView.dequeueReusableCell(withIdentifier: CellIds.MoviePlotTableViewCell.rawValue, for: indexPath) as? MoviePlotTableViewCell else { return .init() }
            plotCell.prepareForDrawing(with: bindedMovieDetail)
            return plotCell
        case .castAndDirector:
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CellIds.MovieCastTableViewCell.rawValue, for: indexPath) as? MovieCastTableViewCell else { return .init() }
            castCell.prepareForDrawing(with: bindedMovieDetail)
            return castCell
        }
    }
}
