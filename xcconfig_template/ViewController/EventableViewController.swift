//
//  EventableViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

public typealias Completion<T> = (T) -> ()

final class EventableViewController: UIViewController {
    public var event: Completion<Event>?

    override func viewDidLoad() {
        super.viewDidLoad()
        event?(.viewDidLoad)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        event?(.viewDidAppear)
    }
}

extension EventableViewController {
    enum Event {
        case viewDidLoad
        case viewDidAppear
    }
}
