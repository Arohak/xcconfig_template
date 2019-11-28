//
//  URLSession+Ext.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/23/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

extension URLSession {
    enum HTTPError: LocalizedError {
        case invalidResponse
        case invalidStatusCode
        case noData
    }

    func dataTask(url: URL) -> AHPromise<Data> {
        return AHPromise<Data> { [unowned self] fulfill, reject in
            self.dataTask(with: url) { data, response, error in
                if let error = error {
                    reject(error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    reject(HTTPError.invalidResponse)
                    return
                }
                guard response.statusCode >= 200, response.statusCode < 300 else {
                    reject(HTTPError.invalidStatusCode)
                    return
                }
                guard let data = data else {
                    reject(HTTPError.noData)
                    return
                }
                fulfill(data)
            }.resume()
        }
    }
}

enum TodoError: LocalizedError {
    case missing
}

struct APIManager {
    
    struct Todo: Decodable {
        let id: Int
        let userId: Int
        let title: String
        let completed: Bool
    }
    
    static func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        URLSession.shared.dataTask(url: url)
        .thenMap { data in
            return try JSONDecoder().decode([Todo].self, from: data)
        }
        .thenMap { todos -> Todo in
            guard let first = todos.first else {
                throw TodoError.missing
            }
            return first
        }
        .then { first in
            let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(first.id)")!
            return URLSession.shared.dataTask(url: url)
        }
        .thenMap { data in
            try JSONDecoder().decode(Todo.self, from: data)
        }
        .onSuccess { todo in
            print(todo)
        }
        .onFailure(queue: .main) { error in
            print(error.localizedDescription)
        }
    }
}

