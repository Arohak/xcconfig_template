//
//  KeyPathExamples.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/20/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

struct Article {
    let id: Int
    let title: String
    let body: String
}

/// ***********************************
/// - 1 -
/// ***********************************
extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

let one = Article(id: 1, title: "title_1", body: "body_1")
let two = Article(id: 2, title: "title_2", body: "body_2")
let three = Article(id: 3, title: "title_3", body: "body_3")
let articles = [one, two, three]

// - a - Base map
let ids = articles.map { $0.id }
let titles = articles.map { $0.title }

// - b - KeyPath map
let articleIds = articles.map(\.id)
let articleSources = articles.map(\.title)

// - c - KeyPath sorted
let sortedIds = articles.sorted(by: \.id)
let sortedTitle = articles.sorted(by: \.title)




/// ***********************************
/// - 2 -
/// ***********************************
struct CellConfigurator<Model> {
    let titleKeyPath: KeyPath<Model, Int>
    let subtitleKeyPath: KeyPath<Model, String>

    func configure(_ cell: UITableViewCell, for model: Model) {
        cell.textLabel?.text = "\(model[keyPath: titleKeyPath])"
        cell.detailTextLabel?.text = model[keyPath: subtitleKeyPath]
    }
}

let cellConfigurator = CellConfigurator<Article>(titleKeyPath: \.id, subtitleKeyPath: \.title)




/// ***********************************
/// - 3 -
/// ***********************************
func setter<Object: AnyObject, Value>(for object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) -> (Value) -> () {
    return { [weak object] value in
        object?[keyPath: keyPath] = value
    }
}

class ListViewController {
    class Loader {
        func load(then: ([String]) -> ()) {
            let items = ["Hayk", "Asatur", "Narek"]
            return then(items)
        }
    }

    private let loader = Loader()
    private var items = [String]()

    // - a - Base
    func loadItems_() {
        loader.load { [weak self] items in
            self?.items = items
        }
    }

    // - b - KeyPath
    func loadItems() {
        loader.load(then: setter(for: self, keyPath: \.items))
    }
}
