//
//  Styling.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 26/08/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

infix operator <>
public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

func layer(color: CGColor, radius: CGFloat, width: CGFloat) -> ((UIView) -> ()) {
    return {
        $0.layer.borderColor    = color
        $0.layer.cornerRadius   = radius
        $0.layer.borderWidth    = width
    }
}

let baseStyle: (UIView) -> Void = {
    $0.backgroundColor = .black
    $0.clipsToBounds = true
}

let redLayerStyle: (UITextField) -> Void =
    layer(color: UIColor.red.cgColor, radius: 15, width: 2)

let blackLayerStyle =
    baseStyle <> layer(color: UIColor.black.cgColor, radius: 10, width: 1)


