//
//  APIProvider.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/4/20.
//  Copyright © 2020 Ara Hakobyan. All rights reserved.
//

import UIKit
import AHProvider


typealias CompletionHandler<T> = (Result<T, AHError>) -> Void

class APIProvider {
    private let session: URLSession
    
    public init(with session: URLSession = .init(configuration: .default)) {
        self.session = session
        URLCache.shared = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
    }
    
    public func fetch<T: Decodable>(with url: URL, completion: @escaping CompletionHandler<T>) {
        let task = session.dataTask(with: url) { (data, urlReponse, error) in
            self.handle(with: data, error, completion)
        }
        task.resume()
    }
    
    public func fetch(with url: URL,
                      method: String,
                      headers: [String: String]? = nil,
                      completion: @escaping CompletionHandler<[String: Any]>) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        let task = session.dataTask(with: request) { (data, urlReponse, error) in
            if let data = data, error == nil {
                let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
                let dict = jsonObject as! [String: Any]
                completion(.success(dict))
            } else if let error = error {
                completion(.failure(.badURL(error)))
            }
        }
        task.resume()
    }
    
    public func fetch<T: Decodable>(with url: URL,
                                    method: String,
                                    headers: [String: String]? = nil,
                                    completion: @escaping CompletionHandler<T>) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        let task = session.dataTask(with: urlRequest) { (data, urlReponse, error) in
            self.handle(with: data, error, completion)
        }
        task.resume()
    }
    
    public func loadImage(at url: URL, completion: @escaping CompletionHandler<UIImage>) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(.badURL(error))) }
                } else {
                    DispatchQueue.main.async { completion(.failure(.dataMissing)) }
                }
                return
            }
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidImageData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
    }
    
    private func handle<T: Decodable>(with data: Data?, _ error: Error?, _ completion: @escaping CompletionHandler<T>) {
        guard let data = data else {
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.badURL(error)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.dataMissing))
                }
            }
            return
        }
        DispatchQueue.main.async {
            if let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []),
               let _ = jsonAny as? [String: Any] {
                if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(decoded))
                } else {
                    completion(.failure(.responseDecodingFailed))
                }
            } else {
                completion(.failure(.invalidJsonResponse))
            }
        }
    }
}
