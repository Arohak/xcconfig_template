//
//  StaticTableDataProvider.swift
//  MG2
//
//  Created by Ara Hakobyan on 4/25/19.
//  Copyright © 2019 Marktguru. All rights reserved.
//

import UIKit

class StaticTableDataProvider: NSObject {
    typealias Cell = StaticTableCell
    
    private var user: UserProfile
    weak var tableView: UITableView?

    required init(with user: UserProfile, table: UITableView) {
        self.user = user
        super.init()

        tableView = table
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.registerCell(Cell.self)
    }
}

//MARK: - Datasource and Delegate
extension StaticTableDataProvider: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(rawValue: section)!.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath) as Cell
        let section = Section(rawValue: indexPath.section)!
        let row = section.rows[indexPath.row]
        let filed = user[row] ?? ""
        let data = StaticModel(title: row.title,
                               filed: filed,
                               placeholder: row.placeholder,
                               isValid: row.isValid(for: filed),
                               indexPath: indexPath)
        cell.config(with: data, delegate: self)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

//MARK: - UITextFieldDelegate
extension StaticTableDataProvider: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? BaseTextField else { return false }
        textField.resignFirstResponder()
        reloadRow(with: textField)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? BaseTextField else { return }
        reloadRow(with: textField)
    }

    private func reloadRow(with textField: BaseTextField) {
        let indexPath = textField.indexPath
        let section = Section(rawValue: indexPath.section)!
        let row = section.rows[indexPath.row]
        user[row] = textField.text
        tableView?.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: - Nested Types
extension StaticTableDataProvider {
    enum Section: Int, CaseIterable {
        case personal
        case sizing

        var title: String {
            switch self {
            case .personal: return "Personal Info"
            case .sizing: return "Sizing Info"
            }
        }

        var rows: [Row] {
            switch self {
            case .personal: return [.firstName, .lastName, .zipCode]
            case .sizing: return [.width, .height, .size]
            }
        }
    }
    
    enum Row: String {
        case firstName  = "First Name"
        case lastName   = "Last Name"
        case zipCode    = "Zip Code"
        case width      = "Width"
        case height     = "Height"
        case size       = "Size"

        var title: String {
            return  self.rawValue
        }

        var placeholder: String {
            return "Description"
        }

        func isValid(for value: String) -> Bool {
            switch self {
            case .firstName, .lastName, .zipCode:
                return value.count > 5
            case .width, .height, .size:
                return Float(value) != nil
            }
        }
    }
}
