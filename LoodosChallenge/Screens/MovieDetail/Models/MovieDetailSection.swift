//
//  MovieDetailSection.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Foundation
import UIKit

struct MovieDetailSection {
    
    internal enum SectionType {
        case moviePoster
        case info
        case manageMedia
        case plot
        case castAndDirector
    }
    
    let type: SectionType
    let mediaManageItems: [MediaManageItem]
    
    init(type: SectionType, mediaManageItems: [MediaManageItem] = []) {
        self.type = type
        self.mediaManageItems = mediaManageItems
    }
    
    var itemCount: Int {
        switch self.type {
        case .moviePoster, .info, .plot, .castAndDirector:
            return 1
        case .manageMedia:
            return mediaManageItems.count
        }
    }
    
    static var createAll: [MovieDetailSection] {
        return [
            .init(type: .moviePoster),
            .init(type: .info),
            .init(type: .manageMedia, mediaManageItems: MediaManageItem.createAll),
            .init(type: .plot),
            .init(type: .castAndDirector),
        ]
    }
    
}

struct MediaManageItem {
    
    internal enum ItemType {
        case play
        case download
    }
    
    let type: ItemType
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    
    init(type: ItemType, title: String, titleColor: UIColor, backgroundColor: UIColor) {
        self.type = type
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
    
    static var createAll: [MediaManageItem] {
        return [
            .init(type: .play, title: "􀊄  Play", titleColor: .init(color: .background), backgroundColor: .init(color: .viewTitle)),
            .init(type: .download, title: "􀄩  Download", titleColor: .init(color: .viewTitle, alpha: 0.9), backgroundColor: .init(color: .searchBarBackground))
        ]
    }
}
