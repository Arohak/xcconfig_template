//
//  Model.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

protocol DynamicModelType {
    var title: String { get }
}

struct DynamicModel: DynamicModelType {
    let title: String
}
