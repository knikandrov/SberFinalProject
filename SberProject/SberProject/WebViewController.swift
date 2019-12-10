//
//  WebViewController.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 08.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit
import WebKit

class WebVIewController: UIViewController, WKNavigationDelegate {
    
    var webView:WKWebView!
    let item = ItemsService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.frame = view.frame
        let url = item.singleItem[0].link
        print(url)
        let request = URLRequest(url: URL(string: "\(url)")!)
        webView.load(request)
        view.addSubview(webView)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

