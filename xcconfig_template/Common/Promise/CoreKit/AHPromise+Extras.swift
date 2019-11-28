//
//  AHPromise+Extras.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11/23/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

public enum AHPromises {
    
    public enum Errors: Error {
        case validation
        case timeout
    }
    
    public static func first<T>(queue: DispatchQueue? = nil,
                                _ block: @escaping () throws -> AHPromise<T>) -> AHPromise<T> {
        return AHPromise(value: ()).then(queue: queue, block)
    }
    
    public static func first<T>(queue: DispatchQueue? = nil,
                                _ block: @escaping () throws -> T) -> AHPromise<T> {
        return AHPromise(value: ()).thenMap(queue: queue, block)
    }
    
    @discardableResult
    public static func delay(_ delay: DispatchTimeInterval) -> AHPromise<()> {
        return AHPromise<()> { fulfill, _ in
            let time = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: time) {
                fulfill(())
            }
        }
    }
    
    @discardableResult
    public static func timeout<T>(_ timeout: DispatchTimeInterval) -> AHPromise<T> {
        return AHPromise<T> { _, reject in
            AHPromises.delay(timeout)
            .onSuccess {
                reject(AHPromises.Errors.timeout)
            }
        }
    }
    
    @discardableResult
    public static func all<T>(_ promises: [AHPromise<T>]) -> AHPromise<[T]> {
        return AHPromise<[T]> { fulfill, reject in
            guard !promises.isEmpty else {
                return fulfill([])
            }
            
            for promise in promises {
                promise.then(success: { value in
                    if !promises.contains(where: { $0.isRejected || $0.isPending }) {
                        fulfill(promises.compactMap { $0.value })
                    }
                }, failure: reject)
            }
        }
    }

    @discardableResult
    public static func wait<T>(_ promises: [AHPromise<T>]) -> AHPromise<Void> {
        return AHPromise<Void> { fulfill, _ in
            guard !promises.isEmpty else {
                return fulfill(())
            }
            let complete: ((Any) -> Void) = { _ in
                if !promises.contains(where: { $0.isPending }) {
                    fulfill(())
                }
            }
            for promise in promises {
                promise.then(success: complete, failure: complete)
            }
        }
    }

    @discardableResult
    public static func race<T>(_ promises: [AHPromise<T>]) -> AHPromise<T> {
        return AHPromise<T> { fulfill, reject in
            guard !promises.isEmpty else {
                fatalError("Could not race empty promises array.")
            }
            for promise in promises {
                promise.then(success: fulfill, failure: reject)
            }
        }
    }
    
    @discardableResult
    public static func zip<T1, T2>(_ p1: AHPromise<T1>,
                                   _ last: AHPromise<T2>) -> AHPromise<(T1, T2)> {
        return AHPromise<(T1, T2)> { fulfill, reject in
            let resolver: (Any) -> Void = { _ in
                if let firstValue = p1.value, let secondValue = last.value {
                    fulfill((firstValue, secondValue))
                }
            }
            p1.then(success: resolver, failure: reject)
            last.then(success: resolver, failure: reject)
        }
    }
    
    @discardableResult
    public static func zip<T1, T2, T3>(_ p1: AHPromise<T1>,
                                       _ p2: AHPromise<T2>,
                                       _ last: AHPromise<T3>) -> AHPromise<(T1, T2, T3)> {
        return AHPromise<(T1, T2, T3)> { (fulfill: @escaping ((T1, T2, T3)) -> Void, reject: @escaping (Error) -> Void) in
            let zipped: AHPromise<(T1, T2)> = zip(p1, p2)

            let resolver: (Any) -> Void = { _ in
                if let zippedValue = zipped.value, let lastValue = last.value {
                    fulfill((zippedValue.0, zippedValue.1, lastValue))
                }
            }
            zipped.then(success: resolver, failure: reject)
            last.then(success: resolver, failure: reject)
        }
    }

    @discardableResult
    public static func zip<T1, T2, T3, T4>(_ p1: AHPromise<T1>,
                                           _ p2: AHPromise<T2>,
                                           _ p3: AHPromise<T3>,
                                           _ last: AHPromise<T4>) -> AHPromise<(T1, T2, T3, T4)> {
        return AHPromise<(T1, T2, T3, T4)> { (fulfill: @escaping ((T1, T2, T3, T4)) -> Void, reject: @escaping (Error) -> Void) in
            let zipped: AHPromise<(T1, T2, T3)> = zip(p1, p2, p3)

            let resolver: (Any) -> Void = { _ in
                if let zippedValue = zipped.value, let lastValue = last.value {
                    fulfill((zippedValue.0, zippedValue.1, zippedValue.2, lastValue))
                }
            }
            zipped.then(success: resolver, failure: reject)
            last.then(success: resolver, failure: reject)
        }
    }

    @discardableResult
    public static func retry<T>(times: Int,
                                delay: DispatchTimeInterval,
                                generate: @escaping () -> AHPromise<T>) -> AHPromise<T> {
        if times <= 0 {
            return generate()
        }
        return AHPromise<T> { fulfill, reject in
            generate().recover { _ in
                return AHPromises.delay(delay).then { _ in
                    return self.retry(times: times - 1, delay: delay, generate: generate)
                }
            }
            .then(success: fulfill, failure: reject)
        }
    }
}
