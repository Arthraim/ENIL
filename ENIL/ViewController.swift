//
//  ViewController.swift
//  ENIL
//
//  Created by Arthur Wang on 2/20/17.
//  Copyright © 2017 YANGAPP. All rights reserved.
//

import UIKit
import SnapKit
import SwiftHEXColors
import Toast_Swift

class ViewController: UIViewController {

    var textView: UITextView!
    var copyButton: UIButton!
    var shareButton: UIButton!
    var monstaButton: UIButton!
    var copyRightLabel: UILabel!

    func updateText(text: String) {
        textView.text = text
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpControls()
    }

    func setUpControls() {
        textView = UITextView()
        copyButton = UIButton(type: .system)
        shareButton = UIButton(type: .system)
        monstaButton = UIButton(type: .system)
        copyRightLabel = UILabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ENIL"
        view.backgroundColor = UIColor.white

        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor(hexString: "333333")
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = .link
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20 + 44 + 20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        copyButton.setTitle("Copy All", for: .normal)
        copyButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints({ (make) in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.left.equalTo(view).offset(20)
        })
        copyButton.addTarget(self, action: #selector(copyAction(_:)), for: .touchUpInside)

        shareButton.setTitle("Share All", for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints({ (make) in
            make.top.equalTo(copyButton)
            make.left.equalTo(copyButton.snp.right).offset(10)
            make.width.equalTo(copyButton)
        })
        shareButton.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)

        monstaButton.setTitle("Go MonSt", for: .normal)
        monstaButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(monstaButton)
        monstaButton.snp.makeConstraints({ (make) in
            make.top.equalTo(shareButton)
            make.left.equalTo(shareButton.snp.right).offset(10)
            make.width.equalTo(shareButton)
            make.right.equalTo(view).offset(-20)
        })
        monstaButton.addTarget(self, action: #selector(monstaAction(_:)), for: .touchUpInside)

        copyRightLabel.text = "Copyright YANGAPP.com all rights reserved"
        copyRightLabel.font = UIFont.systemFont(ofSize: 14)
        copyRightLabel.textColor = UIColor(hexString: "999999")
        copyRightLabel.textAlignment = .center
        copyRightLabel.minimumScaleFactor = 0.5
        view.addSubview(copyRightLabel)
        copyRightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(copyButton.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func copyAction(_ sender: UIButton) {
        UIPasteboard.general.string = textView.text
        view.makeToast("Copied to your clipboard~")
    }

    func shareAction(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: [textView.text], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender;
        present(activityVC, animated: true, completion: nil)
    }

    func monstaAction(_ sender: UIButton) {
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

