//
//  Eventable.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

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

final class EventableViewController: UIViewController {
    internal var events = Event<Case>()

    override func viewDidLoad() {
        super.viewDidLoad()
        events[.viewDidLoad]?(nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        events[.viewDidAppear]?(nil)
    }
}

extension EventableViewController: Eventable {
    enum Case {
        case viewDidLoad
        case viewDidAppear
    }
}
