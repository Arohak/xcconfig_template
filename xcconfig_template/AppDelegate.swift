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

//        MARK: - ComponentViewController
        vc = ComponentViewController()
        
        //MARK: - ObserverViewController
//        vc = ObserversViewController()
        
        //MARK: - DiffableDataSourceViewController
//        if #available(iOS 13.0, *) {
//            vc = DiffableDataSourceViewController()
//        }

        //MARK: - DataSourceViewController
//        vc = DataSourceViewController()

//        MARK: - StyleViewController
//        vc = StyleViewController()

        //MARK: - Guardian TableViewController
//        vc = GuardianTableViewController()

        //MARK: - Staic Table View Enum
//        vc = StaticTableViewController()

        //MARK: - Dynamic Table View Generic
//        vc = DynamicTableViewController()

        //MARK: - Eventable
//        let vc = EventableViewController()
//        vc.event = { type in
//            switch type {
//            case .viewDidLoad:
//                print("viewDidLoad")
//            case .viewDidAppear:
//                print("viewDidAppear")
//            }
//        }
//        self.vc = vc

        //MARK: - Promise
//        APIManager.getData()

        //MARK: - Property Wrapper
//        ConsoleLoggedConfig.test()
//        UserDefaultConfig.test()
//        AtomicConfig.test()

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
//
//        registerForPushNotifications()
//
//        print(Configuration.apiKey)
        
        return true
    }
}

// MARK: - UNUserNotificationCenterDelegate -
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        {
//            "aps" : {
//                "alert" : {
//                    "title" : "arohak.com",
//                    "body" : "A weekly blog about iOS development"
//                },
//                "badge" : 5
//            },
//            "Simulator Target Bundle": "com.arohak.xcconfig-template_dev"
//        }
        
//        xcrun simctl list
//        xcrun simctl push <device> <bundle-identifier> <path-to-apns-file>
//        xcrun simctl push booted payload.apns
//        xcrun simctl push 40A14EA5-ECEC-4589-A8FA-E98C2679579F payload.apns
        
        print("userInfo: \(response.notification.request.content.userInfo)")
        completionHandler()
    }
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

