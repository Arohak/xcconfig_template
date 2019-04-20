/**
 * Copyright © 2017 Ara Hakobyan. All rights reserved.
 */

import Foundation

enum Guardian {
    case searchFeed(_ config: ConfigProtocol, _ size: String)
}

extension Guardian: AHRequest {
    var method: AHHttpMethod {
        switch self {
        case .searchFeed(let config, _):
            print(config.baseUrl)
            print(config.apiKey)
            print()
            return .get
        }
    }

    var baseURL: URL {
        switch self {
        case .searchFeed(let config, _):
            let url = URL(string: config.baseUrl)!
            return url
        }
    }

    var path: String {
        switch self {
        case .searchFeed:
            return "search"
        }
    }

    var params: [String : String]? {
        switch self {
        case .searchFeed(let config, let size):
            return ["format": config.format, "page-size": size]
        }
    }

    var headers: [String : String]? {
        switch self {
        case .searchFeed(let config, _):
            let key = ["api-key" : config.apiKey]
            return key
        }
    }
}
