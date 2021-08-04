//
//  WineCard.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 02.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import UIKit

extension Components {
    static func makeWine() -> Component<WineModel, WineEvent> {
        let background = Views.background(color: .red)
        let image = Views.Cards.image()
        let title = Views.Cards.title()
        let button = Views.Cards.button()
        
        return Component {
            Views.Layout.makeWine(
                background: background,
                cardItems: [image, title],
                footer: button
            )
        } update: { model in
            image.image = UIImage(named: model.imageStr)
            title.text = model.name
            button.setTitle(model.buttonTitle, for: .normal)
        } eventBinding: { eventHandler in
            button.action = { eventHandler?(.buy) }
        }
    }
}

struct WineModel {
    let name: String
    let imageStr: String
    let buttonTitle: String
    
    static var mock: Self {
        return .init(name: "Wine Name", imageStr: "ic_test", buttonTitle: "Button Title")
    }
}

enum WineEvent {
    case buy
}
