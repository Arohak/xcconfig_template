//
//  ObservationToken.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

class ObservationToken {
    typealias CancellClosure = () -> Void
    private let cancellationClosure: CancellClosure

    init(cancellationClosure: @escaping CancellClosure) {
        self.cancellationClosure = cancellationClosure
    }

    func cancel() {
        cancellationClosure()
    }
}
