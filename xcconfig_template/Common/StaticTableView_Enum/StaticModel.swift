//
//  StaticModel.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

protocol StaticModelType {
    var title: String { get }
    var filed: String? { get }
    var placeholder: String { get }
    var isValid: Bool { get }
    var indexPath: IndexPath { get }
}

struct StaticModel: StaticModelType {
    let title: String
    let filed: String?
    let placeholder: String
    let isValid: Bool
    let indexPath: IndexPath
}
