//
//  DiffableDataSourceViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 30/11/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class DiffableDataSourceViewController: UITableViewController {
    var friends = [ Contact(name: "friend_1"), Contact(name: "friend_2"), Contact(name: "friend_3") ]
    var family = [ Contact(name: "family_1"), Contact(name: "family_2"), Contact(name: "family_3") ]
    var coworkers = [ Contact(name: "coworker_1"), Contact(name: "coworker_2"), Contact(name: "coworker_3") ]

    private lazy var list = ContactList(friends: friends, family: family, coworkers: coworkers)
    private lazy var dataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerCell(UITableViewCell.self)
        tableView.dataSource = dataSource

        config()
    }

    private func config() {
        update(with: list)

        (1...12).forEach { delay in
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(delay)) {
                if delay % 4 == 0 {
                    self.update(with: self.list)
                    self.friends = self.list.friends
                    self.family = self.list.family
                    self.coworkers = self.list.coworkers
                } else {
                    self.updateList()
                }
            }
        }
    }

    private func updateList() {
        friends.removeFirst()
        family.removeLast()
        coworkers.removeFirst()
        let list = ContactList(friends: friends, family: family, coworkers: coworkers)
        update(with: list)
    }
}

@available(iOS 13.0, *)
extension DiffableDataSourceViewController {
    enum Section: CaseIterable {
        case friends
        case family
        case coworkers
    }

    struct Contact: Hashable {
        var name: String
    }

    struct ContactList {
        var friends: [Contact]
        var family: [Contact]
        var coworkers: [Contact]
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Contact> {
        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, contact in
            let cell = tableView.dequeueReusableCell(indexPath)
            cell.textLabel?.text = contact.name
            return cell
        }
    }

    func update(with list: ContactList, animate: Bool = true) {
        let snapshot = getSnapshot(from: list)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }

    func getSnapshot(from list: ContactList) -> NSDiffableDataSourceSnapshot<Section, Contact> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Contact>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.friends, toSection: .friends)
        snapshot.appendItems(list.family, toSection: .family)
        snapshot.appendItems(list.coworkers, toSection: .coworkers)
        return snapshot
    }
}

