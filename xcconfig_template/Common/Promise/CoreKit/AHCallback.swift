//
//  Callback.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/23/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

struct AHCallback<T> {
    let queue: DispatchQueue
    let onSuccess: ((T) -> Void)
    let onFailure: ((Error) -> Void)
    
    init(queue: DispatchQueue,
         onSuccess: @escaping ((T) -> Void),
         onFailure: @escaping ((Error) -> Void)) {
        self.queue = queue
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
}
