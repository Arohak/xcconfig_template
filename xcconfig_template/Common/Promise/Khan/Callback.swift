//
//  Callback.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/23/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

struct Callback<Value> {
    let onFulfilled: (Value) -> Void
    let onRejected: (Error) -> Void
    let executionContext: ExecutionContext
    
    func callFulfill(_ value: Value, completion: @escaping () -> Void = { }) {
        executionContext.execute({
            self.onFulfilled(value)
            completion()
        })
    }
    
    func callReject(_ error: Error, completion: @escaping () -> Void = { }) {
        executionContext.execute({
            self.onRejected(error)
            completion()
        })
    }
}
