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
    var viewController: ViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        viewController = ViewController()
        window?.rootViewController = UINavigationController.init(rootViewController: viewController!)
        window?.makeKeyAndVisible()

        if let url: URL = launchOptions?[UIApplicationLaunchOptionsKey.url] as? URL {
            updateUI(content: extractTextFromURL(url: url),
                     shouldDelay: true)
        } else {
            updateUI(content: "NO AVAILABLE LINK\n\nClick link below to go back to MONSTER STRIKE, then send invitation link via LINE. It will automatically go back to this app.",
                     shouldDelay: true)
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        updateUI(content: extractTextFromURL(url: url), shouldDelay: false)
        return true
    }

    func extractTextFromURL(url: URL) -> String {
        return url.path.replacingOccurrences(of: "/text/", with: "")
    }

    // IMPORTANT
    // by the time didFinishLaunchingWithOptions invoked, self.viewController might not created yet
    // so add a delay here before update text if needed
    func updateUI(content: String, shouldDelay: Bool) {
        let deadline = shouldDelay ? DispatchTime.now() + 1 : DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: deadline) { [unowned self] in
            self.viewController?.updateText(text: content)
        }
    }

}

