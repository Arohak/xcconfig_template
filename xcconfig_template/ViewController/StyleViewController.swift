//
//  StyleViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 26/08/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

class StyleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
}

private extension StyleViewController {
    func configUI() {
        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hello Word", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        blackLayerStyle(button)
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.cornerRadius = 8
//        button.layer.borderWidth = 2
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80.0).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont.systemFont(ofSize: 14)
        redLayerStyle(textfield)
//        textfield.layer.borderColor = UIColor.red.cgColor
//        textfield.layer.cornerRadius = 15
//        textfield.layer.borderWidth = 1
        view.addSubview(textfield)
        textfield.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        textfield.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textfield.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
    }
}
