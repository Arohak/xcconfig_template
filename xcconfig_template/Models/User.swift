//
//  User.swift
//  AHProvider_Example
//
//  Created by Ara Hakobyan on 30/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct User: Decodable {
    let name: String
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int
    let name: String
}
