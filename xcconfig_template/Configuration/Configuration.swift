/**
 * Copyright © 2017 Ara Hakobyan. All rights reserved.
 */

import Foundation

protocol ConfigProtocol {
    static var baseURL: URL { get }
    static var apiKey: String { get }
    static var format: String { get }
}

enum Configuration {
    typealias Dict = [String: Any]
    static let infoDictionary = getInfoDictionary()

    static func getInfoDictionary() -> Dict {
        let bundle = Bundle.main
        let configPath = bundle.path(forResource: "Configuration", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: configPath) as? Dict

        var temp = Dict()
        if let dict = plist?["Common"] as? Dict {
            temp = dict
        }
        if let environment = bundle.infoDictionary?["Environment"] as? String, let dict = plist?[environment] as? Dict {
            temp = temp.merging(dict) { $1 }
        }
        return temp
    }

    static private func value<T>(for key: String) -> T {
        guard let value = infoDictionary[key] as? T else {
            fatalError("Invalid or missing Info.plist key: \(key)")
        }
        return value
    }
}

extension Configuration: ConfigProtocol {
    struct Keys {
        static let baseUrl = "base_url"
        static let apiKey = "api_key"
        static let format = "format"
    }

    static var baseURL: URL {
        return URL(string: value(for: Keys.baseUrl))!
    }

    static var apiKey: String {
        return value(for: Keys.apiKey)
    }

    static var format: String {
        return value(for: Keys.format)
    }
}
