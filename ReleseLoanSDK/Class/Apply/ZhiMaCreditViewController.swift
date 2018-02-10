//
//  ZhiMaCreditViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ZhiMaCreditViewController: BaseViewController {
    
    let webView = UIWebView()
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "芝麻信用认证"
        
//        let tableView = BaseTableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.estimatedRowHeight = 44
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
        
        
        view.addSubview(webView)
//        webView.delegate = self
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
//        let commitButton = UIButton.bottomButton(title: "同意授权")
//        view.addSubview(commitButton)
//        commitButton.snp.makeConstraints { (make) in
//            make.bottom.left.right.equalTo(view)
//            make.height.equalTo(50)
//        }
    }
    
    override func initDataSource() {
        super.initDataSource()
        CertificationModel.getZhiMaUrl { (data) in
            
            DispatchQueue.main.async {
                if let url = URL(string: data) {
                    let request = URLRequest.init(url: url)
                    self.webView.loadRequest(request)
                }
            }
        }
    }
    
}

//extension ZhiMaCreditViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return tableView.mm_dequeueStaticCell(indexPath)
//    }
//}

