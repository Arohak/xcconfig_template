//
//  Eventable.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

public typealias Callback = (Any?) -> ()
public typealias Event<T: Hashable> = [T: Callback]

protocol Eventable {
    associatedtype Case: Hashable
    var events: Event<Case> { get set }

    @discardableResult
    mutating func on(eventType: Case, do callback: Callback?) -> Self
}

extension Eventable {
    @discardableResult
    mutating func on(eventType: Case, do callback: Callback?) -> Self {
        events[eventType] = callback
        return self
    }
}
