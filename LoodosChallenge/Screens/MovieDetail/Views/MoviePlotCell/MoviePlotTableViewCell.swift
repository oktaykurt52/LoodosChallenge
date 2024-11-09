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
            plotText.createTitle(customizableText: .init(text: movieDetail.plot ?? "", alignment: .left, textColor: .init(color: .movieDetailPlot), fontFamily: .SFPro, fontWeight: .Regular, fontSize: 14))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(plotText)
        plotText.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
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
