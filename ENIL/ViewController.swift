//
//  ViewController.swift
//  ENIL
//
//  Created by Arthur Wang on 2/20/17.
//  Copyright © 2017 YANGAPP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func wechatAction(_ sender: Any) {
        openUrlString(urlString: "weixin://")
    }

    @IBAction func telegramAction(_ sender: Any) {
        openUrlString(urlString: "tg://")
    }

    @IBAction func monsterStrikingAction(_ sender: Any) {
        openUrlString(urlString: "monsterstrike-app://")
    }

    func openUrlString(urlString: String) {
        if let url = URL(string: urlString) {
            if (UIApplication.shared.canOpenURL(url)) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        } else {
            let alert = UIAlertController(title: "Cannot open this link", message: nil, preferredStyle: .alert)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}

