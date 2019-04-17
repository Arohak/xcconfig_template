//
//  NewsFeed.swift
//  AHProvider_Example
//
//  Created by Ara Hakobyan on 30/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct NewsFeed: Decodable {
    let response: Response
}

struct Response: Decodable {
    let page: Int
    let status: String
    let results: [Rezult]
    
    public enum CodingKeys: String, CodingKey {
        case page = "pageSize"
        case status
        case results
    }
}

struct Rezult: Decodable {
    let pillarName: String
    let sectionName: String
}
