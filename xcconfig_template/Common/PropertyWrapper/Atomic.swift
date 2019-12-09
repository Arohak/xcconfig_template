//
//  Atomic.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 08/12/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

@propertyWrapper
class Atomic<Value> {
    private let queue = DispatchQueue(label: "com.vadimbulavin.atomic")
    private var value: Value

    var projectedValue: Atomic<Value> {
        return self
    }

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }

    var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }

    func mutate(_ mutation: (inout Value) -> Void) {
        return queue.sync {
            mutation(&value)
        }
    }
}

struct AtomicConfig {
    @Atomic
    static var x = 0

    @Atomic
    static var array: [Int] = [1, 2, 3]

    static func test() {
        $x.mutate { $0 = 100 }
        print("x: \(x)")

        $array.mutate { $0[1] = 123 }
        print("array: \(array)")

        let one = Atomic(wrappedValue: 1)
        one.mutate { $0 += 1 }
        print("one: \(one.wrappedValue)")
    }
}
