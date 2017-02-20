//
//  AppDelegate.swift
//  ENIL
//
//  Created by Arthur Wang on 2/20/17.
//  Copyright © 2017 YANGAPP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let u: URL = launchOptions?[UIApplicationLaunchOptionsKey.url] as? URL {
            handleURL(url: u)
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        handleURL(url: url)
        return true
    }

    func handleURL(url: URL) {
//        let alert = UIAlertController(title: "1", message: url.absoluteString, preferredStyle: .alert)
//        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        (self.window?.rootViewController as! ViewController).textView.text
            = url.path.replacingOccurrences(of: "/text/", with: "")
    }

}

