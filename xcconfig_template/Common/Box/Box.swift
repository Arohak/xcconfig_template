//
//  Box.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/11/20.
//  Copyright © 2020 Ara Hakobyan. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
