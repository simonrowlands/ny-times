//
//  ArticleDetailViewController.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import UIKit

final class ArticleDetailViewController: UIViewController {
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!

    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.largeTitleDisplayMode = .never
        
        title = article?.source
        
        article?.getMedia { [weak self] image in
            self?.headerImageView.image = image
        }
        
        titleLabel.text = article?.title
        contentsTextView.text = article?.abstract
    }
}
