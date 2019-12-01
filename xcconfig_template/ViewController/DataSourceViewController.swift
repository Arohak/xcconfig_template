//
//  DataSourceViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 27/11/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

class DataSourceViewController: UITableViewController {
    struct Message {
        let title: String
    }
    struct Contact {
        let number: String
    }
    
    let messages = [ Message(title: "1"), Message(title: "2"), Message(title: "3") ]
    let contacts = [ Contact(number: "a"), Contact(number: "b"), Contact(number: "c") ]

    lazy var dataSource = SectionedTableViewDataSource(dataSources: [
        TableViewDataSource.make(for: contacts),
        TableViewDataSource.make(for: messages)
    ])

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerCell(UITableViewCell.self)
        tableView.dataSource = dataSource
    }
}
