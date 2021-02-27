//
//  ViewController.swift
//  My_Framework_Test
//
//  Created by Ara Hakobyan on 23/12/2017.
//  Copyright © 2017 Ara Hakobyan. All rights reserved.
//

import UIKit
import AHProvider

public class GuardianTableViewController: UIViewController {
    private let provider = AHProvider<Guardian>()
    
    private let apiProvider = APIProvider()
    
    private let oneView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let twoView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

//    private var feed: NewsFeed? {
//        didSet {
//            tableView.reloadData()
//        }
//    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(oneView)
//        oneView.anchors(top: (anchor: view.topAnchor, constant: 20),
//                        left: (anchor: view.leftAnchor, constant: 20),
//                        right: (anchor: view.rightAnchor, constant: 20),
//                        bottom: (anchor: view.bottomAnchor, constant: 400))
        
        view.addSubview(twoView)
//        twoView.anchors(top: (anchor: view.topAnchor, constant: 40),
//                        left: (anchor: view.leftAnchor, constant: 40),
//                        right: (anchor: view.rightAnchor, constant: 40),
//                        bottom: (anchor: view.bottomAnchor, constant: 40))
        
        twoView.anchors(top: .init(anchor: oneView.bottomAnchor, constant: 40),
                        centerX: .init(anchor: oneView.centerXAnchor),
                        height: 200, width: 200)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        searchGuardianFeed()
        getData()
    }
    
    func getData() {
        let url: URL = "https://content.guardianapis.com/search?page-size=1"
        let method = "GET"
        let headers = ["api-key": "test"]
        
        apiProvider.fetch(with: url, method: method, headers: headers) { result in
            switch result {
            case .success(let data):
                print("data: ", data)
            case .failure(let error):
                print("error: ", error)
            }
        }
        
//        apiProvider.fetch(with: url, method: method, headers: headers) { (response: Result<NewsFeed, AHError>) in
//            switch response {
//            case .failure(let error):
//                print(error)
//            case .success(let result):
//                print(result)
//            }
//        }
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

//    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return feed?.response.results.count ?? 0
//    }
//
//    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
////        if cell == nil {
////            cell = UITableViewCell(style: .value2, reuseIdentifier: "cellIdentifier")
////        }
////        let item = feed?.response.results[indexPath.row]
//        cell.textLabel?.text = "1"//item?.pillarName
////        cell.detailTextLabel?.text = "22222" //item?.sectionName
//        return cell
//    }
}

