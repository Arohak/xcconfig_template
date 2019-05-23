/**
 * Copyright © 2017 Ara Hakobyan. All rights reserved.
 */

import Foundation
import AHProvider

enum Guardian {
    case searchFeed(_ size: String)
}

extension Guardian: AHRequest {
    var method: AHHttpMethod {
        switch self {
        case .searchFeed:
            print(Configuration.baseURL)
            print(Configuration.apiKey)
            print()
            return .get
        }
    }

    var baseURL: URL {
        return Configuration.baseURL
    }

    var path: String {
        switch self {
        case .searchFeed:
            return "search"
        }
    }

    var params: [String : String]? {
        switch self {
        case .searchFeed(let size):
            return ["format": Configuration.format, "page-size": size]
        }
    }

    var headers: [String : String]? {
        switch self {
        case .searchFeed:
            let key = ["api-key" : Configuration.apiKey]
            return key
        }
    }
}
