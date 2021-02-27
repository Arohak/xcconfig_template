//
//  UIView+Ext.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/8/20.
//  Copyright © 2020 Ara Hakobyan. All rights reserved.
//

import UIKit

struct Layout<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
    var constant: CGFloat = 0
    var multiplier: CGFloat = 0
}

extension UIView {
    
    func anchors(top: Layout<NSLayoutYAxisAnchor>? = nil,
                 left: Layout<NSLayoutXAxisAnchor>? = nil,
                 right: Layout<NSLayoutXAxisAnchor>? = nil,
                 bottom: Layout<NSLayoutYAxisAnchor>? = nil,
                 centerX: Layout<NSLayoutXAxisAnchor>? = nil,
                 centerY: Layout<NSLayoutYAxisAnchor>? = nil,
                 height: CGFloat? = nil,
                 width: CGFloat? = nil)
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { topAnchor.constraint(equalTo: top.anchor, constant: top.constant).isActive = true }
        if let left = left { leftAnchor.constraint(equalTo: left.anchor, constant: left.constant).isActive = true }
        if let right = right { rightAnchor.constraint(equalTo: right.anchor, constant: -right.constant).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant).isActive = true }
        if let centerX = centerX { centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant).isActive = true }
        if let centerY = centerY { centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant).isActive = true }
        if let height = height { heightAnchor.constraint(equalToConstant: height).isActive = true }
        if let width = width { widthAnchor.constraint(equalToConstant: width).isActive = true }
    }
}

//view.addSubview(oneView)
//oneView.anchors(top: (anchor: view.topAnchor, constant: 20),
//                left: (anchor: view.leftAnchor, constant: 20),
//                right: (anchor: view.rightAnchor, constant: 20),
//                bottom: (anchor: view.bottomAnchor, constant: 400))
//
//view.addSubview(twoView)
//twoView.anchors(top: .init(anchor: oneView.bottomAnchor, constant: 40),
//                centerX: .init(anchor: oneView.centerXAnchor),
//                height: 200, width: 200)
