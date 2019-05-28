//
//  Extention.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static let reuseId = String(describing: self)
}

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: Cell.reuseId)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else {
            fatalError("can't dequeue cell")
        }
        return cell
    }
}
