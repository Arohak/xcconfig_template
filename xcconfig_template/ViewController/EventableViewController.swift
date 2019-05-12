//
//  EventableViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

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
