//
//  Config.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 17/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

protocol ConfigProtocol {
    var baseUrl: String { get }
    var apiKey: String { get }
}

final class Config {
    private let config: NSDictionary

    init(dictionary: NSDictionary) {
        config = dictionary
    }

    convenience init() {
        let bundle = Bundle.main
        let configPath = bundle.path(forResource: "config", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: configPath)!

        let dict = NSMutableDictionary()
        if let commonConfig = config["Common"] as? [AnyHashable: Any] {

            dict.addEntries(from: commonConfig)

        }
        if let environment = bundle.infoDictionary!["Environment"] as? String {
            if let environmentConfig = config[environment] as? [AnyHashable: Any] {
                dict.addEntries(from: environmentConfig)
            }
        }

        self.init(dictionary: dict)
    }
}

extension Config: ConfigProtocol {

    var baseUrl: String {
        return config["base_url"] as! String
    }

    var apiKey: String {
        return config["api_key"] as! String
    }
}
