//
//  Dictionary+Ext.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

extension Dictionary where Key == UUID {
    mutating func insert(_ value: Value) -> UUID {
        let id = UUID()
        self[id] = value
        return id
    }
}
