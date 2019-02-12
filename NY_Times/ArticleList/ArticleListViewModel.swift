//
//  ArticleListViewModel.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import Foundation

protocol ArticleListViewModelDelegate: class {
    func articleListViewModel(didReceiveArticles articles: [Article]?)
}

final class ArticleListViewModel {
    
    weak var delegate: ArticleListViewModelDelegate?
    
    var networkingAPI = ArticleAPI()

    func getArticles(completion: (() -> ())? = nil) {
        networkingAPI.mostViewedArticles(section: .allSections, period: .week) { [weak self] articles in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.articleListViewModel(didReceiveArticles: articles)
            completion?()
        }
    }
}
