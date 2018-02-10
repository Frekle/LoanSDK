//
//  UsualQuestionsViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class UsualQuestionsViewController: BaseViewController {

    let questions = ["如何借款？", "如何获得更高额度", "审核相关问题？", "如何还款？", "账户与用户相关问题", "安全提示相关问题？"]
    let urlStrings = ["http://apk.boyacx.com/renxinyong/html/loan.html",
                      "http://apk.boyacx.com/renxinyong/html/highQuota.html",
                      "http://apk.boyacx.com/renxinyong/html/examine.html",
                      "http://apk.boyacx.com/renxinyong/html/repayment.html",
                      "http://apk.boyacx.com/renxinyong/html/accountsAndUsers.html",
                      "http://apk.boyacx.com/renxinyong/html/securityTips.html"]
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "常见问题"
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

}

extension UsualQuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_reuseCell(indexPath) as CommonTextCell
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = BaseWebViewController()
        webView.urlString = urlStrings[indexPath.row]
        webView.title = questions[indexPath.row]
        self.navigationController?.pushViewController(webView, animated: true)
    }
}
