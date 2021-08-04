//
//  HeroComponent.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import UIKit

extension Components {
    static func makeHero() -> Component<HeroModel, Void> {
        let background = Views.background(color: .green)
        let image = Views.Cards.image()
        let title = Views.Hero.title()
        
        return Component {
            Views.Layout.makeHero(
                background: background,
                items: [image, title]
            )
        } update: { model in
            image.image = UIImage(named: model.imageStr)
            title.text = model.name
        } eventBinding: { _ in }
    }
}

struct HeroModel {
    let name: String
    let imageStr: String
    
    static var mock: Self {
        return .init(name: "Hero Name", imageStr: "ic_test")
    }
}
