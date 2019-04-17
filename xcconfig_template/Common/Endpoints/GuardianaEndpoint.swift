
import Foundation

let config = Config()

enum GuardianaEndpoint {
    case guardian(pageSize: String)
}

extension GuardianaEndpoint: AHRequest {

    var method: AHHttpMethod {
        switch self {
        case .guardian:
            print(config.baseUrl)
            print(config.apiKey)
            print()
            return .get
        }
    }
    
    var baseURL: URL {
        switch self {
        case .guardian:
            let url = URL(string: config.baseUrl)!
            return url
        }
    }
    
    var path: String {
        switch self {
        case .guardian:
            return "search"
        }
    }

    var params: [String : String]? {
        switch self {
        case .guardian(let pageSize):
            return ["format": "json", "page-size": pageSize]
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .guardian:
            let key = ["api-key" : config.apiKey]
            return key
        }
    }
}
