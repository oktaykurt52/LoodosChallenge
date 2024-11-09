//
//  MovieInfoTableViewCell.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieAgeRating: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieDuration: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieHD: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieSubtitleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            movieYear, movieAgeRating, movieDuration, movieHD
        ])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var imdbIcon: UIImageView = {
        let imageView = UIImageView(image: .movieDetailIMDB)
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        return imageView
    }()
    
    lazy var ratingText: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var viewCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var imdbStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            imdbIcon, ratingText, viewCount
        ])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var movieDetailInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            movieTitle, movieSubtitleStack, imdbStack
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var bindedMovie: MovieDetail? {
        didSet {
            guard let movieDetail = bindedMovie else { return }
            movieTitle.createTitle(customizableText: .init(text: movieDetail.title ?? "", alignment: .left, textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Bold, fontSize: 20))
            movieYear.createTitle(customizableText: .init(text: movieDetail.year ?? "", alignment: .left, textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
            movieAgeRating.createTitle(customizableText: .init(text: movieDetail.rated ?? "", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
            movieDuration.createTitle(customizableText: .init(text: movieDetail.runtime ?? "", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
            movieHD.createTitle(customizableText: .init(text: "HD", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .SemiBold, fontSize: 10))
            ratingText.createTitle(customizableText: .init(text: "IMDb Rating \(movieDetail.imdbRating ?? "0")/10", alignment: .left, textColor: .init(color: .viewTitle), fontFamily: .SFPro, fontWeight: .SemiBold, fontSize: 17))
            viewCount.createTitle(customizableText: .init(text: movieDetail.imdbVotes ?? "", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .SemiBold, fontSize: 10))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieDetailInfoStack)
        movieDetailInfoStack.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 14, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //...
    }
    
    func prepareForDrawing(with movieDetail: MovieDetail?) {
        createView(properties: .init(backgroundColor: .clear))
        bindedMovie = movieDetail
    }
}
