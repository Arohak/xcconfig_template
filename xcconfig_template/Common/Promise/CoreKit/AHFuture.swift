//
//  AHFuture.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/22/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

public struct AHFuture<T> {
    public var result: Result<T, Error>?
    
    public init(result: Result<T, Error>? = nil) {
        self.result = result
    }
    
    public var value: T? {
        guard let result = self.result, case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    public var error: Error? {
        guard let result = self.result, case .failure(let error) = result else {
            return nil
        }
        return error
    }
    
    public var isPending: Bool {
        return self.result == nil
    }
    
    public var isFulfilled: Bool {
        return self.value != nil
    }
    
    public var isRejected: Bool {
        return self.error != nil
    }
}
