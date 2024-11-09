//
//  MoviePlotTableViewCell.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 9.11.2024.
//

import UIKit
import SnapKit

class MoviePlotTableViewCell: UITableViewCell {
    
    lazy var plotText: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var bindedMovieDetail: MovieDetail? {
        didSet {
            guard let movieDetail = bindedMovieDetail else { return }
            plotText.createTitle(customizableText: .init(text: movieDetail.plot ?? "", alignment: .left, textColor: .init(color: .movieDetailPlot), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14, lineBreakMode: .byTruncatingTail))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(plotText)
        plotText.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func prepareForDrawing(with movieDetail: MovieDetail?) {
        createView(properties: .init(backgroundColor: .clear))
        bindedMovieDetail = movieDetail
    }
}
