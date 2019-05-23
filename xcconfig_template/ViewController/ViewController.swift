//
//  ViewController.swift
//  My_Framework_Test
//
//  Created by Ara Hakobyan on 23/12/2017.
//  Copyright © 2017 Ara Hakobyan. All rights reserved.
//

import UIKit
import AHProvider

class ViewController: UIViewController {
    let provider = AHProvider<Guardian>()

    override func viewDidLoad() {
        super.viewDidLoad()

        useGuardian()
    }

    func useGuardian() {
        provider.requestDecodable(.searchFeed("2")) { (response: Result<NewsFeed, AHError>) in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
    }
    
}

