/**
 * Copyright © 2017 Ara Hakobyan. All rights reserved.
 */

import Foundation

public typealias Dict = [String: Any]

protocol AHProviderType: class {
    associatedtype Request: AHRequest

    func request(_ request: Request, completion: @escaping (Result<Dict, AHError>) -> Void)
    func requestDecodable<Response: Decodable>(_ request: Request, completion: @escaping (Result<Response, AHError>) -> Void)
}

open class AHProvider<Request: AHRequest>: AHProviderType {
    fileprivate let session: URLSession
    
    public init() {
        self.session = URLSession(configuration: .default)
        URLCache.shared = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
    }

    public func request(_ request: Request, completion: @escaping (Result<Dict, AHError>) -> Void) {
        tryRequest(request) { data in
            switch data {
            case .failure(let error):
                completion(.failure(.badURL(error)))
            case .success(let object) :
                if let data = object as? Data,
                    let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []),
                    let json = jsonAny as? Dict {
                    completion(.success(json))
                } else {
                    completion(.failure(AHError.invalidJsonResponse))
                }
            }
        }
    }

    public func requestDecodable<Response: Decodable>(_ request: Request, completion: @escaping (Result<Response, AHError>) -> Void) {
        tryRequest(request) { data in
            switch data {
            case .failure(let error):
                completion(.failure(.badURL(error)))
            case .success(let object) :
                if let data = object as? Data,
                    let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []),
                    let _ = jsonAny as? [String: Any] {
                    if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
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
}

extension AHProvider {
    private func tryRequest(_ request: Request, completion: @escaping (Result<Any, AHError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.baseURL.scheme
        urlComponents.queryItems = request.params?.toQueryItems
        urlComponents.host = request.baseURL.host
        urlComponents.path = request.baseURL.path + "/" + request.path

        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.string
        urlRequest.allHTTPHeaderFields = request.headers
        let task = session.dataTask(with: urlRequest) { (data, urlReponse, error) in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(.badURL(error))) }
                } else {
                    DispatchQueue.main.async { completion(.failure(.dataMissing)) }
                }
                return
            }
            DispatchQueue.main.async { completion(.success(data)) }
        }
        task.resume()
    }
}

extension AHProvider {
    public func loadImage(at url: URL, completion: @escaping (Result<UIImage, AHError>) -> Void) -> URLSessionDataTask {
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
        return task
    }
}

extension Dictionary where Key == String, Value == String {
    var toQueryItems: [URLQueryItem]? {
        var temp: [URLQueryItem]? = []
        for obj in self {
            let queryItem = URLQueryItem(name: obj.key, value: obj.value)
            temp?.append(queryItem)
        }
        
        return temp
    }
}

