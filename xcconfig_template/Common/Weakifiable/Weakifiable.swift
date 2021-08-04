//
//  Weakifiable.swift
//  MG2
//
//  Created by Ara Hakobyan on 02/11/2019.
//  Copyright © 2019 Marktguru. All rights reserved.
//

import Foundation

protocol Weakifiable: AnyObject { }

extension NSObject: Weakifiable {}

extension Weakifiable {
    func weakify(_ code: @escaping (Self) -> Void) -> () -> (Void) {
        return { [weak self] in
            guard let self = self else { return }
            code(self)
        }
    }

    func weakify<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> (Void) {
        return { [weak self] arg in
            guard let self = self else { return }
            code(self, arg)
        }
    }
}
