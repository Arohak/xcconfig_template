//
//  DynamicTableViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

class DynamicTableViewController: BaseTableViewController<MyCell, DynamicModel> {
    override func viewDidLoad() {
        super.viewDidLoad()

        models = [
            DynamicModel(title: "0"),
            DynamicModel(title: "1")
        ]
    }
}
