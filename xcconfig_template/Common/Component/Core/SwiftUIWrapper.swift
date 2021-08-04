//
//  SwiftUIWrapper.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SwiftUIWrapper<Model, Event>: UIViewRepresentable {
    let view: UIView
    let component: Component<Model, Event>
    var model: Model
    
    init(model: Model, _ builder: () -> Component<Model, Event>) {
        self.component = builder()
        self.view = component.view
        self.model = model
    }
    
    func makeUIView(context: Context) -> some UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        component.update(model)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
