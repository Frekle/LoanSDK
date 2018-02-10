//
//  FaceIdWebViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/24.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import WebKit

class FaceIdWebViewController: BaseViewController {
    
    let webView = UIWebView()
    
    var faceTokenData = FaceIdTokenData()
    
    var successCallback: ((FaceIdResultData) -> Void)?
    
    override func initUserInterface() {
        
        title = "身份认证"
        
        view.addSubview(webView)
        webView.delegate = self
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    override func initDataSource() {
        view.showLoading()
        CertificationModel.faceIdToken { (data) in
            self.faceTokenData = data
            DispatchQueue.main.async {
                let urlString = FaceIdApi.doVertification(token: data.token).path + "?token=" + data.token
                if let url = URL(string: urlString) {
                    let request = URLRequest.init(url: url)
                    self.webView.loadRequest(request)
                }
            }
        }
    }

}

extension FaceIdWebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let scheme = request.url?.absoluteString {
            if scheme.contains(Constants.faceIdReturnUrl) {
                CertificationModel.getResult(bizId: faceTokenData.bizId, callback: { (data) in
                    switch data.resultStatus {
                    case .cancelled, .notStarted:
                        self.navigationController?.popViewController(animated: true)
                    case .ok:
                        self.successCallback?(data)
                        self.navigationController?.popViewController(animated: true)
                        break
                    }
                })
                return false
            } else if scheme.contains(Constants.faceIdNotifyUrl) {
                return true
            }
        }
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        view.hidAllHud()
    }
}
