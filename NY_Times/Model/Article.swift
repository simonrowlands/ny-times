//
//  Article.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import UIKit

class Article: Codable {
    let title: String
    let byline: String
    let abstract: String
    let source: String
    let publishedDate: Date
    
    let media: [Media]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case byline
        case abstract
        case source
        case publishedDate = "published_date"
        case media
    }
    
    func getMedia(completion: @escaping (UIImage) -> ()) {
        if let media = media?.first, let metadata = media.metadata?.first {
            let url = metadata.url
            if let imageURL = URL(string: url) {
                
                DispatchQueue.global().async {
                    let pictureData = try? Data(contentsOf: imageURL)
                    
                    if let pictureData = pictureData, let articleImage = UIImage(data: pictureData) {
                        DispatchQueue.main.async {
                            completion(articleImage)
                        }
                    }
                }
            }
        }
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
