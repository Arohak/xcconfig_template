//
//  ReferencePreview.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public protocol ReferencePreview: PreviewProvider {
    static var title: String { get }
    static func navigationLink() -> NavigationLink<Text, Self.Previews>
}

@available(iOS 13.0, *)
extension ReferencePreview {
    static func navigationLink() -> NavigationLink<Text, Self.Previews> {
        return NavigationLink(destination: previews) {
            Text(title).font(.headline)
        }
    }
}
