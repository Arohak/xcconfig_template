//
//  ViewController.swift
//  My_Framework_Test
//
//  Created by Ara Hakobyan on 23/12/2017.
//  Copyright © 2017 Ara Hakobyan. All rights reserved.
//

import UIKit
import AHProvider

public class GuardianTableViewController: UITableViewController {
    private let provider = AHProvider<Guardian>()
    private var feed: NewsFeed? {
        didSet {
            tableView.reloadData()
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchGuardianFeed()
    }

    func searchGuardianFeed() {
        provider.request(.searchFeed("2")) { (respone: Result<Dict, AHError>) in
            
        }
//        provider.requestDecodable(.searchFeed("20")) { (response: Result<NewsFeed, AHError>) in
//            switch response {
//            case .failure(let error):
//                print(error)
//            case .success(let result):
//                print(result)
//                self.feed = result
//            }
//        }
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed?.response.results.count ?? 0
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        if cell == nil {
//            cell = UITableViewCell(style: .value2, reuseIdentifier: "cellIdentifier")
//        }
//        let item = feed?.response.results[indexPath.row]
        cell.textLabel?.text = "1"//item?.pillarName
//        cell.detailTextLabel?.text = "22222" //item?.sectionName
        return cell
    }
}

