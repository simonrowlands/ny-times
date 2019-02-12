//
//  NetworkingAPI.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import Foundation

struct Endpoints {
    static let mostViewed = NetworkingAPI.baseURL + "mostpopular/v2/mostviewed/%@/%@.json"
}

class NetworkingAPI {
    
    static let baseURL = "https://api.nytimes.com/svc/"
    static let apiKey = "Y9nWMTvKlO17ldTGxrbDZlMsw2gbXb7j"
    
    static let defaultQueryParams = ["api-key": NetworkingAPI.apiKey]
    
    static func createURL(from url: String, with parameters: [String: Any]) -> URL? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems!.append(queryItem)
        }
        
        return urlComponents.url
    }
}
