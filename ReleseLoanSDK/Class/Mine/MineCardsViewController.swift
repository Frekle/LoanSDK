//
//  MineCardsViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class MineCardsViewController: BaseViewController {

    var dataSource = [MyBankCardData]()
    let tableView = BaseTableView()
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "我的银行卡"
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.addAccountCallback = {
            self.gotoAddAccount()
        }
    }
    
    override func initDataSource() {
        super.initDataSource()
        getData()
    }
    
    func getData() {
        RequestOfMineModel.getMyBankCardInfo { (data) in
            if let data = data {
                self.tableView.noData = false
                self.dataSource.removeAll()
                self.dataSource.append(data)
                self.tableView.reloadData()
            } else {
                self.tableView.noData = true
                self.tableView.showEmptyCart()
            }
        }
    }
    
    func gotoAddAccount() {
        let cashVC = CashCardViewController()
        cashVC.title = "更改还款账户"
        cashVC.authCallback = {
            self.getData()
        }
        self.navigationController?.pushViewController(cashVC, animated: true)
    }
}

extension MineCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 65
        default:
            return 125 + 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource.count == 0 {
            let cell = tableView.mm_reuseCell(indexPath) as ChangeCardManagerCell
            cell.responseToButtonBlock = {
                self.gotoAddAccount()
            }
            return cell
        } else {
            switch indexPath.row {
            case 0:
                let cell = tableView.mm_reuseCell(indexPath) as MineCardCell
                cell.myCardData = dataSource[indexPath.row]
                return cell
            default:
                let cell = tableView.mm_reuseCell(indexPath) as ChangeCardManagerCell
                cell.responseToButtonBlock = {
                    self.gotoAddAccount()
                }
                return cell
            }
        }

    }
}
