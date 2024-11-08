//
//  MovieCollectionViewCell.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 148).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieDetails: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieTextStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            movieTitle, movieDetails
        ])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    var bindedMovie: Movie? {
        didSet {
            guard let movie = bindedMovie else { return }
            movieTitle.createTitle(customizableText: .init(text: movie.title ?? "", textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Bold, fontSize: 20))
            movieDetails.createTitle(customizableText: .init(text: movie.year ?? "", textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
            moviePoster.setImageWithUrl(url: movie.poster ?? "") { _ in }
        }
    }
    
    func prepareForDrawing(with movie: Movie?) {
        createView(properties: .init(backgroundColor: .clear))
        addSubview(moviePoster)
        addSubview(movieTextStack)
        //...
        moviePoster.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        movieTextStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(moviePoster.snp.right).inset(-20)
        }
        bindedMovie = movie
    }
}
