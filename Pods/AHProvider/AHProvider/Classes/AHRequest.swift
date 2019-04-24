/**
 * Copyright © 2017 Ara Hakobyan. All rights reserved.
 * APIService.swift
 */

import Foundation

public protocol AHRequest {
    var method: AHHttpMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var params: [String: String]? { get }
    var headers: [String: String]? { get }
}

public enum AHHttpMethod : String {
    case get, post, put, patch, delete
    
    var string: String {
        return self.rawValue.uppercased()
    }
}

public enum AHError: Error {
    case badURL(Error)
    case invalidUrl
    case dataMissing
    case invalidJsonResponse
    case responseDecodingFailed
    case invalidImageData
}

