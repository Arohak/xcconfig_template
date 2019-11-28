//
//  AHFuture.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/22/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

open class AHPromise<T> {
    private var future: AHFuture<T>
    private var callbacks: [AHCallback<T>] = []
    private let lockQueue = DispatchQueue(label: "dispatch.promise.lock.queue", qos: .userInitiated)
    private var executionQueue: DispatchQueue
    
    public init(_ on: DispatchQueue = .global(qos: .userInitiated), _ future: AHFuture<T>? = nil) {
        self.executionQueue = on
        self.future = future ?? AHFuture()
    }
    
    public convenience init(queue: DispatchQueue = .global(qos: .default), value: T) {
        self.init(queue, AHFuture(result: .success(value)))
    }
    
    public convenience init(queue: DispatchQueue = .global(qos: .default), error: Error) {
        self.init(queue, AHFuture(result: .failure(error)))
    }
    
    public convenience init(queue: DispatchQueue = .global(qos: .default),
                            block: @escaping (_ fulfill: @escaping ((T) -> Void),
                                              _ reject: @escaping ((Error) -> Void)) throws -> Void) {
        self.init(queue)
        
        queue.async {
            do {
                try block(self.fulfill, self.reject)
            }
            catch {
                self.reject(error)
            }
        }
    }
    
    public convenience init(queue: DispatchQueue = .global(qos: .default),
                            block: @escaping () throws -> T) {
        self.init(queue)
        
        queue.async {
            do {
                self.fulfill(try block())
            }
            catch {
                self.reject(error)
            }
        }
    }
    
    @discardableResult
    public func then(queue: DispatchQueue? = nil,
                          success: @escaping ((T) -> Void),
                          failure: @escaping ((Error) -> Void)) -> AHPromise<T> {
        let executionQueue = queue ?? self.executionQueue
        self.addCallbacks(queue: executionQueue, onFulfilled: success, onRejected: failure)
        return self
    }
    
    @discardableResult
    public func then<U>(queue: DispatchQueue? = nil, _ f: @escaping ((T) throws -> AHPromise<U>)) -> AHPromise<U> {
        
        let executionQueue = queue ?? self.executionQueue
        
        return AHPromise<U>(queue: self.executionQueue) { fulfill, reject in
            self.addCallbacks(
                queue: executionQueue,
                onFulfilled: { value in
                    do {
                        try f(value).then(queue: queue, success: fulfill, failure: reject)
                    }
                    catch {
                        reject(error)
                    }
                },
                onRejected: reject
            )
        }
    }
    
    @discardableResult
    public func thenMap<U>(queue: DispatchQueue? = nil, _ f: @escaping ((T) throws -> U)) -> AHPromise<U> {
        
        let executionQueue = queue ?? self.executionQueue
        
        return self.then(queue: executionQueue) { value -> AHPromise<U> in
            do {
                return AHPromise<U>(queue: self.executionQueue, value: try f(value))
            }
            catch {
                return AHPromise<U>(queue: self.executionQueue, error: error)
            }
        }
    }
    
    @discardableResult
    public func onSuccess(queue: DispatchQueue? = nil, _ success: @escaping ((T) -> Void)) -> AHPromise<T> {
        return self.then(queue: queue, success: success, failure: { _ in })
    }
    
    @discardableResult
    public func onFailure(queue: DispatchQueue? = nil, _ failure: @escaping ((Error) -> Void)) -> AHPromise<T> {
        return self.then(queue: queue, success: { _ in }, failure: failure)
    }
    
    private func update(_ future: AHFuture<T>) {
        guard self.isPending else {
            return
        }
        self.lockQueue.sync {
            self.future = future
        }
        self.runCallbacks()
    }
    
    public func fulfill(_ value: T) {
        self.update(AHFuture(result: .success(value)))
    }
    
    public func reject(_ error: Error) {
        self.update(AHFuture(result: .failure(error)))
    }
    
    public var isPending: Bool {
        return !self.isFulfilled && !self.isRejected
    }
    
    public var isFulfilled: Bool {
        return self.value != nil
    }
    
    public var isRejected: Bool {
        return self.error != nil
    }
    
    public var value: T? {
        return self.lockQueue.sync {
            return self.future.value
        }
    }
    
    public var error: Error? {
        return self.lockQueue.sync {
            return self.future.error
        }
    }
    
    private func addCallbacks(queue: DispatchQueue,
                              onFulfilled: @escaping ((T) -> Void),
                              onRejected: @escaping ((Error) -> Void)) {
        let callback = AHCallback(queue: queue, onSuccess: onFulfilled, onFailure: onRejected)
        self.lockQueue.async {
            self.callbacks.append(callback)
        }
        self.runCallbacks()
    }
    
    private func runCallbacks() {
        self.lockQueue.async(execute: {
            guard let callback = self.callbacks.first, !self.future.isPending else {
                return
            }
            self.callbacks.removeFirst()
            
            let group = DispatchGroup()
            group.notify(queue: callback.queue) {
                self.runCallbacks()
            }
            switch self.future.result! {
            case .success(let value):
                callback.queue.async(group: group) {
                    callback.onSuccess(value)
                }
            case .failure(let error):
                callback.queue.async(group: group) {
                    callback.onFailure(error)
                }
            }
        })
    }
}

public extension AHPromise {
    
    @discardableResult
    func tap(queue: DispatchQueue? = nil, _ block: @escaping (() -> Void)) -> AHPromise<T> {
        return self.thenMap(queue: queue) { value -> T in
            block()
            return value
        }
    }
    
    @discardableResult
    func tap(queue: DispatchQueue? = nil, _ block: @escaping ((T) -> Void)) -> AHPromise<T> {
        return self.thenMap(queue: queue) { value -> T in
            block(value)
            return value
        }
    }
    
    @discardableResult
    func validate(_ condition: @escaping (T) -> Bool) -> AHPromise<T> {
        return self.thenMap { value -> T in
            guard condition(value) else {
                throw AHPromises.Errors.validation
            }
            return value
        }
    }
    
    @discardableResult
    func always(queue: DispatchQueue? = nil, _ block: @escaping () -> Void) -> AHPromise<T> {
        return self.then(queue: queue, success: { _ in block() }, failure: { _ in block() })
    }
    
    @discardableResult
    func timeout(_ timeout: DispatchTimeInterval) -> AHPromise<T> {
        return AHPromises.race([self, AHPromises.timeout(timeout)])
    }
    
    @discardableResult
    func recover(recovery: @escaping (Error) throws -> AHPromise<T>) -> AHPromise<T> {
        return AHPromise<T> { fulfill, reject in
            self.then(success: fulfill, failure: { error in
                do {
                    try recovery(error).then(success: fulfill, failure: reject)
                }
                catch {
                    reject(error)
                }
            })
        }
    }
    
}
