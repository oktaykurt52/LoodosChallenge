//
//  MoviePosterTableViewCell.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import SnapKit

class MoviePosterTableViewCell: UITableViewCell {
    
    lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var bindedMovie: MovieDetail? {
        didSet {
            guard let movieDetail = bindedMovie else { return }
            moviePoster.setImageWithUrl(url: movieDetail.poster ?? "") { _ in }
        }
    }
    
    func prepareForDrawing(with movieDetail: MovieDetail?) {
        createView(properties: .init(backgroundColor: .clear, cornerRadius: 10, maskedCorners: [
            .topLeft, .topRight
        ]))
        addSubview(moviePoster)
        //...
        moviePoster.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bindedMovie = movieDetail
    }
}
