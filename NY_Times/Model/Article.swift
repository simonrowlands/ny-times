//
//  Article.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let byline: String
    let publishedDate: Date
    
    let media: [Media]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case byline
        case publishedDate = "published_date"
        case media
    }
}

struct Media: Codable {
    let metadata: [MediaMetadata]?
    
    private enum CodingKeys: String, CodingKey {
        case metadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
    let format: String
    let height: Int
    let width: Int
}
