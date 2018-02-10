//
//  AboutUsViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    let leftTitle = ["商务QQ", "商务邮箱", "客服QQ", "客服电话"]
    let details = ["2880637419", "wangxun@9ffenqigo.com", "347856042", "400034566"]
    
    override func initUserInterface() {
        super.initUserInterface()
        title = "意见反馈"
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let companyLabel = UILabel.init(title: "深圳博雅成信金融有限公司", titleColor: UIColor.lightGray, font: UIFont.size14)
        view.addSubview(companyLabel)
        companyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-20)
        }
    }
}

extension AboutUsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_reuseCell(indexPath) as OurLogoCell
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as OurInfoCell
            cell.mainLabel.text = leftTitle[indexPath.row - 1]
            cell.detailLabel.text = details[indexPath.row - 1]
            return cell
        }
    }
}
