//
//  HeroView_Preview.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct HeroView_Preview: ReferencePreview {
    static var title: String = "Hero"
    
    static var previews: some View {
        SwiftUIWrapper(model: HeroModel.mock) { () -> Component<HeroModel, Void> in
            Components.makeHero()
        }
        .previewLayout(.fixed(width: 200, height: 80))
    }
}
