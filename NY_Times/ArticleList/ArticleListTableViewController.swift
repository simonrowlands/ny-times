//
//  ArticleListTableViewController.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import UIKit

final class ArticleListTableViewController: UITableViewController {
    
    private let viewModel = ArticleListViewModel()
    private var articles: [Article]?
    
    let dateFormatter = DateFormatter.yyyyMMdd // Placed here to avoid recreation on every cell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getArticles()
        
        
    }
}

extension ArticleListTableViewController: ArticleListViewModelDelegate {
    func articleListViewModel(didReceiveArticles articles: [Article]?) {
        self.articles = articles
        tableView.reloadData()
    }
}

extension ArticleListTableViewController { // Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        guard let article = articles?[indexPath.row] else {
            return cell
        }
        
        cell.titleLabel.text = article.title
        cell.byLineLabel.text = article.byline
        cell.dateLabel.text = dateFormatter.string(from: article.publishedDate)
        
        cell.loadImage(from: article)
        
        return cell
    }
}

extension ArticleListTableViewController { // Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = articles?[indexPath.row] else {
            return
        }
        
        let articleDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        articleDetailVC.article = article
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }
}
