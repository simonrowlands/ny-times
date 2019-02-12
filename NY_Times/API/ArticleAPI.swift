//
//  ArticleAPI.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import Foundation

final class ArticleAPI: NetworkingAPI {
    
    enum Section: String {
        case allSections = "all-sections"
    }
    
    enum Period: Int {
        case day = 1
        case week = 7
        case month = 30
    }
    
    func mostViewedArticles(section: Section, period: Period, completion: @escaping ([Article]?) -> ()) {
        
        let urlString = String(format: Endpoints.mostViewed, arguments: [section.rawValue, "\(period.rawValue)"])
        
        guard let url = NetworkingAPI.createURL(from: urlString, with: NetworkingAPI.defaultQueryParams) else {
            print("Failed to construct URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print("Error - \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Response did not return a valid (200) status code")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customNYTimes
            
            guard let data = data else {
                print("Response missing data")
                return
            }
            
            do {
                let articles = try decoder.decode(ArticleResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(articles.results)
                }
            } catch (let error) {
                print("Could not read/decode article data from response")
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}

fileprivate struct ArticleResponse: Decodable {
    let results: [Article]
}
