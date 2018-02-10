//
//  BaseWebViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/5.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class BaseWebViewController: BaseViewController {

    
    var webView: UIWebView!
    var urlString = ""
    
    var authCallback: (() -> ())?
    
    override func initUserInterface() {
        
        webView = UIWebView()
        view.addSubview(webView)
        webView.delegate = self
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = URL(string: urlString) {
            view.showLoading()
            let request = URLRequest.init(url: url)
            webView.loadRequest(request)
        }
    }
}

extension BaseWebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        view.hidAllHud()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let scheme = request.url?.absoluteString {
            if scheme.contains(Constants.authtype_online_backurl) {
                authCallback?()
                self.navigationController?.popViewController(animated: true)
                return false
            }
            if scheme.contains("http://sdy.boyacx.com/#/success") {
                authCallback?()
                self.navigationController?.popViewController(animated: true)
                return false
            }
            if scheme.contains("success=1") && scheme.contains("api/v1/gxb/auth_result_notify") {
                authCallback?()
                self.navigationController?.popViewController(animated: true)
                return false
            }
            if scheme.contains("taobao://login.m.taobao.com/qrcodeCheck.htm") || scheme.contains("alipayqr://platformapi/startapp") || scheme.contains("openapp.jdmobile://virtual") {
                if let url = URL(string: scheme) {
                    UIApplication.shared.openURL(url)
                    return false
                }
            }
        }
        return true
    }
}
