//
//  ArticleTableViewCell.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var byLineLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var articleImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        articleImageView.layer.cornerRadius = articleImageView.bounds.width / 2
        articleImageView.clipsToBounds = true
    }
    
    func loadImage(from article: Article) { // This is prone to index errors, only here for demonstration
        if let media = article.media?.first, let metadata = media.metadata?.first {
            let url = metadata.url
            if let imageURL = URL(string: url) {
                
                DispatchQueue.global().async {
                    let pictureData = try? Data(contentsOf: imageURL)
                    
                    if let pictureData = pictureData, let articleImage = UIImage(data: pictureData) {
                        DispatchQueue.main.async { [weak self] in
                            self?.articleImageView.image = articleImage
                        }
                    }
                }
            }
        }
    }
}
