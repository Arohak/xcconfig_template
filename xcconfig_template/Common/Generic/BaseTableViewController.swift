//
//  TableViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

class BaseTableViewController<Cell: BaseTableViewCell<Model>, Model>: UITableViewController {
    var models = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerCell(Cell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath) as Cell
        cell.model = models[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
