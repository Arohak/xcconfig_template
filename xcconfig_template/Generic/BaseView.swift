//
//  BaseTableViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit






class BaseTableViewCell<Model: ModelProtocol>: UITableViewCell {
    var model: Model!
}

class MyCell: BaseTableViewCell<MyModel> {
    var view: MyView!
    override var model: MyModel! {
        didSet {
            setupView()
        }
    }

    private func setupView() {
        if let view = view, contentView.subviews.contains(view) {
            view.config(model)
        } else {
            view = MyView()
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            view.config(model)
        }
    }
}

protocol ModelProtocol {
    var title: String { get }
}

struct MyModel: ModelProtocol {
    let title: String
}

class MyView: UIView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .red
        view.font = UIFont.boldSystemFont(ofSize: 22)
        return view
    }()

    init() {
        super.init(frame: .zero)

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(_ model: MyModel) {
        titleLabel.text = model.title
    }
}

























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
