//
//  CreditCardViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CreditCardViewController: BaseViewController {

    let leftTitle = ["持卡人", "信用卡号"]
    let rightInfo = ["请输入姓名", "请输入信用卡正面的16位数字"]
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "信用卡认证"
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let commitButton = UIButton.bottomButton(title: "提交")
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(50)
        }
    }

}

extension CreditCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_dequeueStaticCell(indexPath) as CreditCardCell
        cell.commonLabel.text = leftTitle[indexPath.row]
        cell.rightTextfield.placeholder = rightInfo[indexPath.row]
        return cell
    }

}
