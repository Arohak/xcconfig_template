/**
 * Copyright © 2017 Ara Hakobyan. All rights reserved.
 */

import Foundation
import AHProvider

public enum Guardian {
    case searchFeed(_ size: String)
}

extension Guardian: AHRequest {
    public var method: AHHttpMethod {
        switch self {
        case .searchFeed:
            print(Configuration.baseURL)
            print(Configuration.apiKey)
            print()
            return .get
        }
    }

    public var baseURL: URL {
        return Configuration.baseURL
    }

    public var path: String {
        switch self {
        case .searchFeed:
            return "search"
        }
    }

    public var params: [String : String]? {
        switch self {
        case .searchFeed(let size):
            return ["format": Configuration.format, "page-size": size]
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .searchFeed:
            let key = ["api-key" : Configuration.apiKey]
            return key
        }
    }
}
