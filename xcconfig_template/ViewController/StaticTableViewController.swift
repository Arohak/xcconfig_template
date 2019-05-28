//
//  StaticTableViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

class StaticTableViewController: UIViewController {
    private var user = UserProfile()
    private var tableDataProvider: StaticTableDataProvider?
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = tableView
        tableDataProvider = StaticTableDataProvider(with: user, table: tableView)
    }
}

class UserProfile {
    typealias Row = StaticTableDataProvider.Row

    var firstName: String?
    var lastName: String?
    var zipCode: String?
    var width: String?
    var height: String?
    var size: String?

    subscript(row: Row) -> String? {
        get { return value(for: row) }
        set { set(value: newValue, for: row) }
    }

    private func set(value: String?, for row: Row) {
        switch row {
        case .firstName: firstName = value
        case .lastName: lastName = value
        case .zipCode: zipCode = value
        case .width: width = value
        case .height: height = value
        case .size: size = value
        }
    }

    private func value(for row: Row) -> String? {
        switch row {
        case .firstName: return firstName
        case .lastName: return lastName
        case .zipCode: return zipCode
        case .width: return width
        case .height: return height
        case .size: return size
        }
    }
}
