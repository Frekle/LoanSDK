//
//  ECommerceViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ECommerceViewController: BaseViewController {

    let leftTitle = ["淘宝", "京东"]
    var details = ["去认证", "去认证"]
    let tableView = BaseTableView()
    var authCallback: (() -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "电商"
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let commitButton = UIButton.bottomButton(title: "提交")
        commitButton.addTarget(self, action: #selector(respondToCommitButton), for: .touchUpInside)
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    override func initDataSource() {
        super.initDataSource()
        
        CertificationModel.checkAuth(authItem: "ecommerce", callback: { (data) in
            self.details[0] = data ? "已认证": "未认证"
            self.tableView.reloadData()
        })
        CertificationModel.checkAuth(authItem: "jd", callback: { (data) in
            self.details[1] = data ? "已认证": "未认证"
            self.tableView.reloadData()
        })
    }
    
    @objc func respondToCommitButton() {
        var authed = true
        details.forEach { (str) in
            if str != "已认证" {
                authed = false
            }
        }
        if authed {
            authCallback?()
            navigationController?.popViewController(animated: true)
        } else {
            view.showHUD("还未全部认证")
        }
    }
}

extension ECommerceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_dequeueStaticCell(indexPath) as ScanBankCardCell
        cell.commonLabel.text = leftTitle[indexPath.row]
        cell.detailLabel.text = details[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            CertificationModel.getAuth(authItem: "ecommerce", callback: { (url) in
                let webVC = BaseWebViewController()
                webVC.title = "电商认证"
                webVC.urlString = url
                webVC.authCallback = {
                    self.details[0] = "已认证"
                    tableView.reloadData()
                }
                self.navigationController?.pushViewController(webVC, animated: true)
            })
        default:
            CertificationModel.getAuth(authItem: "jd", callback: { (url) in
                let webVC = BaseWebViewController()
                webVC.title = "电商认证"
                webVC.urlString = url
                webVC.authCallback = {
                    self.details[1] = "已认证"
                    tableView.reloadData()
                }
                self.navigationController?.pushViewController(webVC, animated: true)
            })
        }
    }
}
