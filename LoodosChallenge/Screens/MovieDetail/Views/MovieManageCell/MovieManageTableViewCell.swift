//
//  MovieManageTableViewCell.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 9.11.2024.
//

import UIKit
import SnapKit

class MovieManageTableViewCell: UITableViewCell {
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return button
    }()
    
    var bindedMediaManageItem: MediaManageItem? {
        didSet {
            guard let mediaManageItem = bindedMediaManageItem else { return }
            actionButton.createButton(properties: .init(title: mediaManageItem.title, textColor: mediaManageItem.titleColor, fontFamily: .SFPro, fontWeight: .SemiBold, fontSize: 17, backgroundColor: mediaManageItem.backgroundColor, cornerRadius: 8))
            actionButton.addTarget(self, action: #selector(actionButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    var bindedMovieDetail: MovieDetail?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func prepareForDrawing(with mediaManageItem: MediaManageItem?, for movieDetail: MovieDetail?) {
        createView(properties: .init(backgroundColor: .clear))
        bindedMovieDetail = movieDetail
        bindedMediaManageItem = mediaManageItem
    }
    
    @objc private func actionButtonTapped(sender: UIButton) {
        guard let movieDetail = bindedMovieDetail else { return }
        print("Action type with:", bindedMediaManageItem?.type as Any, "for movie:", movieDetail.title ?? "")
    }
}
