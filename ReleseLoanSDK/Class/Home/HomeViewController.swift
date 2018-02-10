//
//  HomeViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func initUserInterface() {
        super.initUserInterface()
        
//        title = "注册任信用，最高领取5万额度"
        
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_reuseCell(indexPath) as HomeBannerCell
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as HomeBorrowingCell
            cell.responseToBackBlock = {
                self.navigationController?.pushViewController(CertificationViewController(), animated: true)
            }
            return cell
        }
        
        
    }
}
