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
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieHD: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieSubtitleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            movieYear, createSeperator(), movieHD
        ])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var movieTextStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            movieTitle, movieSubtitleStack
        ])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    var bindedMovie: Movie? {
        didSet {
            guard let movie = bindedMovie else { return }
            movieTitle.createTitle(customizableText: .init(text: movie.title ?? "", numberOfLines: 1, alignment: .left, textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Bold, fontSize: 20, lineBreakMode: .byTruncatingTail))
            movieYear.createTitle(customizableText: .init(text: movie.year ?? "", alignment: .left, textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
            movieHD.createTitle(customizableText: .init(text: " HD ", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .SemiBold, fontSize: 10))
            movieHD.createView(properties: .init(borderColor: .init(color: .textBorder), borderWidth: 1.0, cornerRadius: 4))
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
            $0.right.equalToSuperview().inset(20)
        }
        bindedMovie = movie
    }
}
