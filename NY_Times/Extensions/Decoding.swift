//
//  Decoding.swift
//  NY_Times
//
//  Created by Simon Rowlands on 12/02/2019.
//  Copyright © 2019 simonrowlands. All rights reserved.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static let articleDateDecoder = custom { decoder throws -> Date in
        
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: string) {
            return date
        }
        
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
