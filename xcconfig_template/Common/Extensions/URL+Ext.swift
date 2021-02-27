//
//  URL+Ext.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/8/20.
//  Copyright © 2020 Ara Hakobyan. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }
}
