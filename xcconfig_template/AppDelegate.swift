//
//  AppDelegate.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 17/04/2019.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var vc: UIViewController?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //MARK: - DiffableDataSourceViewController
        if #available(iOS 13.0, *) {
            vc = DiffableDataSourceViewController()
        }

        //MARK: - DataSourceViewController
//        vc = DataSourceViewController()

        //MARK: - StyleViewController
//        vc = StyleViewController()

        //MARK: - Guardian TableViewController
//        vc = GuardianTableViewController()

        //MARK: - Staic Table View Enum
//        vc = StaticTableViewController()

        //MARK: - Dynamic Table View Generic
//        vc = DynamicTableViewController()

        //MARK: - Eventable
//        vc = EventableViewController()
//        vc.on(eventType: .viewDidLoad) { _ in
//            print("viewDidLoad")
//        }
//        vc.on(eventType: .viewDidAppear) { _ in
//            print("viewDidAppear")
//        }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = vc
        self.window!.makeKeyAndVisible()

        print(Configuration.apiKey)

        return true
    }
}

