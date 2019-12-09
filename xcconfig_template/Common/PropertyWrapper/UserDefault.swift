//
//  UserDefault.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 08/12/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultConfig {
    @UserDefault("has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool

    @UserDefault("year_of_birth", defaultValue: 1990)
    static var yearOfBirth: Int

    static func test() {
        print("hasSeen_1: \(hasSeenAppIntroduction)")
        hasSeenAppIntroduction = true
        print("hasSeen_2: \(hasSeenAppIntroduction)")

        print("yearOfBirth_1: \(yearOfBirth)")
        yearOfBirth = 2020
        print("yearOfBirth_2: \(yearOfBirth)")
    }
}
