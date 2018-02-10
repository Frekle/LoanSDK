//
//  ApplySuccessViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ApplySuccessViewController: BaseViewController {

    override func initUserInterface() {
        super.initUserInterface()
        
        title = "申请完成"
        
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

extension ApplySuccessViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_reuseCell(indexPath) as ApplyStepsCell
            cell.stepsImageView.image = UIImage.init(named: "pic_buzhou4")
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as ApplySuccessCell
            cell.responseToBackBlock = {
                if let user = UserInfo.shared().user {
                    if user.certificationed == false {
                        user.certificationed = true
                        UserInfo.shared().setLoginedUserCached(user)
                        UIApplication.shared.keyWindow?.rootViewController = TabBarViewController()
                    } else {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            return cell
        }
        
        
    }
}
