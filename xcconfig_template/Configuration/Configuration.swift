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
    static let infoDictionary = Config.getInfoDictionary()

    struct Keys {
        static let baseUrl = "base_url"
        static let apiKey = "api_key"
        static let format = "format"
    }

    struct Config {
        static func getInfoDictionary() -> NSDictionary {
            let bundle = Bundle.main
            let configPath = bundle.path(forResource: "Configuration", ofType: "plist")!
            let config = NSDictionary(contentsOfFile: configPath)!

            let dict = NSMutableDictionary()
            if let commonConfig = config["Common"] as? [AnyHashable: Any] {
                dict.addEntries(from: commonConfig)
            }
            if let environment = bundle.infoDictionary?["Environment"] as? String {
                if let environmentConfig = config[environment] as? [AnyHashable: Any] {
                    dict.addEntries(from: environmentConfig)
                }
            }
            return dict
        }
    }

    static private func value<T>(for key: String) -> T {
        guard let value = infoDictionary[key] as? T else {
            fatalError("Invalid or missing Info.plist key: \(key)")
        }
        return value
    }
}

extension Configuration: ConfigProtocol {
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
