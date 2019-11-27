//
//  TableViewDataSource.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 27/11/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    typealias CellConfigurator = (Model, Cell) -> Void

    public var models: [Model]
    private let cellConfigurator: CellConfigurator

    init(models: [Model], cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(indexPath) as Cell
        cellConfigurator(model, cell)
        return cell
    }
}

extension TableViewDataSource where Model == Message {
    static func make(for messages: [Message]) -> TableViewDataSource {
        return TableViewDataSource(models: messages) { (message, cell) in
            cell.textLabel?.text = message.title
        }
    }
}

extension TableViewDataSource where Model == Contact {
    static func make(for contacts: [Contact]) -> TableViewDataSource {
        return TableViewDataSource(models: contacts) { (contact, cell) in
            cell.textLabel?.text = contact.number
        }
    }
}
