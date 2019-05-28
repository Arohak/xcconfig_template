//
//  StaticTableCell.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 28/05/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

class StaticTableCell: UITableViewCell {
    private lazy var view: View = {
        let view = View  ()
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        return view
    }()

    public func config(with model: StaticModelType, delegate: UITextFieldDelegate) {
        view.config(with: model)
        view.textField.delegate = delegate
    }
}

extension StaticTableCell {
    class View: UIView {
        lazy var titleLabel: UILabel = {
            let view = UILabel()
            view.textColor = .orange
            view.font = UIFont.boldSystemFont(ofSize: 16)
            return view
        }()

        lazy var textField: BaseTextField = {
            let view = BaseTextField()
            view.font = UIFont.systemFont(ofSize: 16)
            return view
        }()

        init() {
            super.init(frame: .zero)

            let inset: CGFloat = 20
            translatesAutoresizingMaskIntoConstraints = false
            addSubview(titleLabel)
            addSubview(textField)

            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
            titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
            textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func config(with model: StaticModelType) {
            titleLabel.text         = model.title
            textField.text          = model.filed
            textField.placeholder   = model.placeholder
            textField.textColor     = model.isValid ? .gray : .red
            textField.indexPath     = model.indexPath
        }
    }
}

class BaseTextField: UITextField {
    var indexPath = IndexPath()
}
