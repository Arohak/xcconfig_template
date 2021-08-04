//
//  ComponentViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 11.06.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import UIKit

class ComponentViewController: UIViewController {
    let wine = Components.makeWine()
    let hero = Components.makeHero()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configWine()
        configHero()
    }

    private func configWine() {
        wine.update(WineModel.mock)
        wine.onEvent { event in
            print("Action")
        }
        
        view.addSubview(wine.view)
        wine.view.anchors(centerX: .init(anchor: view.centerXAnchor),
                          centerY: .init(anchor: view.centerYAnchor),
                          height: 300,
                          width: 300)
    }
    
    private func configHero() {
        hero.update(HeroModel.mock)
        
        view.addSubview(hero.view)
        hero.view.anchors(top: .init(anchor: wine.view.bottomAnchor, constant: 20),
                          centerX: .init(anchor: view.centerXAnchor),
                          height: 80,
                          width: 200)
    }
}
