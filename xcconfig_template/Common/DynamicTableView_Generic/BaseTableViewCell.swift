//
//  BaseTableViewCell.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

public class BaseTableViewCell<Model: DynamicModelType>: UITableViewCell {
    var model: Model!
}

//MARK: - MyCell
class MyCell: BaseTableViewCell<DynamicModel> {
    typealias Model = DynamicModel
    private lazy var view: View = {
        let view = View  ()
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        return view
    }()

    override var model: Model! {
        didSet {
            view.config(model)
        }
    }
}

extension MyCell {
    class View: UIView {
        lazy var titleLabel: UILabel = {
            let view = UILabel()
            view.textColor = .red
            view.font = UIFont.boldSystemFont(ofSize: 22)
            return view
        }()

        init() {
            super.init(frame: .zero)

            translatesAutoresizingMaskIntoConstraints = false

            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func config(_ model: Model) {
            titleLabel.text = model.title
        }
    }
}

