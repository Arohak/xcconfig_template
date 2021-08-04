//
//  Component.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 02.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import UIKit

enum Components { }


class Component<Model, Event> {
    typealias EventHandler = (Event) -> Void
    
    public let view: UIView
    public let update: (Model) -> Void
    public let onEvent: (EventHandler?) -> Void
    
    init(
        viewBuilder: @escaping () -> UIView,
        update: @escaping (Model) -> Void,
        eventBinding: @escaping (EventHandler?) -> Void
    ) {
        self.view = viewBuilder()
        self.update = update
        self.onEvent = eventBinding
    }
}
