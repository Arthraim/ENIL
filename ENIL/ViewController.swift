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
import Regex
import SafariServices

class ViewController: UIViewController, UITextViewDelegate {

    var textView: UITextView!
    var shareButton: UIButton!
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
        shareButton = UIButton(type: .system)
        copyRightLabel = UILabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ENIL"
        view.backgroundColor = UIColor.white

        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ComicReggaeStd-B", size: 24)!]

        textView.font = UIFont(name: "NewRodinProN-DB", size: 14)
        textView.textColor = UIColor(hexString: "333333")
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = .link
        textView.delegate = self
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            } else {
                make.top.equalTo(view).offset(20)
            }
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        shareButton.setTitle("- ACTIONS -", for: .normal)
        shareButton.titleLabel?.font = UIFont(name: "ComicReggaeStd-B", size: 22)
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints({ (make) in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        })
        shareButton.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)

        copyRightLabel.text = "Copyright YANGAPP.com all rights reserved"
        copyRightLabel.font = UIFont(name: "NewRodinProN-DB", size: 11)
        copyRightLabel.textColor = UIColor(hexString: "999999")
        copyRightLabel.textAlignment = .center
        copyRightLabel.minimumScaleFactor = 0.5
        view.addSubview(copyRightLabel)
        copyRightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(shareButton.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-20)
            } else {
                make.bottom.equalTo(view).offset(-20)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func shareAction(_ sender: UIButton) {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Gamewith Match", style: .default, handler: { action in
            UIPasteboard.general.string = self.textView.text
            // lobby
            let urlStr = "https://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp/lobby#anchor-bbs-title"
            if #available(iOS 9.0, *) {
                self.present(SFSafariViewController(url: URL(string: urlStr)!), animated: true, completion: nil)
            } else {
                self.openUrlString(urlString: urlStr)
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Copy All", style: .default, handler: {action in
            UIPasteboard.general.string = self.textView.text
            self.view.makeToast("Copied ALL TEXT to your clipboard~")
        }))
        actionsheet.addAction(UIAlertAction(title: "Copy Wechat Link", style: .default, handler: {action in
            switch self.textView.text {
            case Regex("NO AVAILABLE LINK"):
                self.view.makeToast("No available link yet!")
            case Regex(".*」\n(.*)\n↑.*"):
                if let link = Regex.lastMatch?.captures[0]
                    , let encodedLink = link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    let hackLink = "http://static.yangapp.com/enil?\(encodedLink)"
                    UIPasteboard.general.string = hackLink
                    self.view.makeToast("Copied HACKED WECHAT LINK to your clipboard, paste it directly in Wechat")
                } else {
                    self.view.makeToast("No valid link found in text!")
                }
            default:
                break
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Share All", style: .default, handler: {action in
            let activityVC = UIActivityViewController(activityItems: [self.textView.text], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender;
            self.present(activityVC, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Go to MonSt", style: .default, handler: {action in
            self.openUrlString(urlString: "monsterstrike-app://")
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionsheet, animated: true, completion: nil)
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

//  MARK: UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if #available(iOS 9.0, *) {
            present(SFSafariViewController(url: URL), animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }

    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        present(SFSafariViewController(url: URL), animated: true, completion: nil)
        return false
    }

}

