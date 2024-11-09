//
//  MovieCastTableViewCell.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 9.11.2024.
//

import UIKit

class MovieCastTableViewCell: UITableViewCell {
    
    lazy var castText: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var directorText: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var textStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            castText, directorText
        ])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var bindedMovieDetail: MovieDetail? {
        didSet {
            guard let movieDetail = bindedMovieDetail else { return }
            castText.createTitle(customizableText: .init(text: "Cast: \(movieDetail.actors ?? "")", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 12))
            directorText.createTitle(customizableText: .init(text: "Directed by: \(movieDetail.director ?? "")", alignment: .left, textColor: .init(color: .movieDetail), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 12))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textStack)
        textStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //...
    }
    
    func prepareForDrawing(with movieDetail: MovieDetail?) {
        bindedMovieDetail = movieDetail
    }
}
