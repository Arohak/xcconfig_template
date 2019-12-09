//
//  ConsoleLogged.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 09/12/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

@propertyWrapper
struct ConsoleLogged<T> {
    private var value: T

    init(wrappedValue: T) {
        self.value = wrappedValue
    }

    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            print("New value is \(newValue)")
        }
    }
}

struct ConsoleLoggedConfig {
    @ConsoleLogged(wrappedValue: "Hello")
    static var message: String

    @ConsoleLogged(wrappedValue: 1)
    static var value: Int

    static func test() {
        message += " World"
        value += 10
    }
}

