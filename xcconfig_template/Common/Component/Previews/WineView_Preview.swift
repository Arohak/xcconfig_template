//
//  WineView_Preview.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct WineView_Preview: ReferencePreview {
    static var title: String = "Wine"
    
    static var previews: some View {
        SwiftUIWrapper(model: WineModel.mock) { () -> Component<WineModel, WineEvent> in
            Components.makeWine()
        }
        .previewLayout(.fixed(width: 300, height: 300))
    }
}
