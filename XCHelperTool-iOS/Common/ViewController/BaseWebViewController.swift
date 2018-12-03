//
//  BaseWebViewController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/21.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import WebKit

/// webView基类
class BaseWebViewController: BaseViewController {

    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.frame)
//        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.groupTableViewBackground
        webView.isOpaque = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame = CGRect(x: 0, y: kNavigationHeight, width: webView.frame.width, height: 2)
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor.red
        webView.addSubview(progressView)
        return progressView
    }()
    
    public var url = "https://www.baidu.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func getData() {
        progressView.setProgress(0.1, animated: true)
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
}

extension BaseWebViewController {
    private func initView() {
        navigationItem.leftBarButtonItems = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.navigationbar_goback(), style: .plain, target: self, action: #selector(goBackAction))
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        getData()
    }
    
    @objc private func goBackAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension BaseWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        isShowErrorView(false)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        isShowErrorView(!webView.canGoBack)
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        decisionHandler(.allow)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        let vc = BaseWebViewController()
//        vc.url = navigationResponse.response.url?.absoluteString ?? ""
//        navigationController?.pushViewController(vc, animated: true)
//        decisionHandler(.cancel)
//    }
}

extension BaseWebViewController {
    /// kvo监听加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is WKWebView && keyPath == "estimatedProgress" {
            progressView.isHidden = false
            if let change = change {
                if let newProgress = change[.newKey] as? Float {
                    progressView.setProgress(newProgress, animated: true)
                    if newProgress >= Float(1.0) {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                            self.progressView.isHidden = true
                            self.progressView.setProgress(0, animated: false)
                        }
                    }
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

