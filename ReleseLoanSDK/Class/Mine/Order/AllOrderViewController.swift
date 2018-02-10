//
//  AllOrderViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/19.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class AllOrderViewController: BaseViewController {
    
    var type: MineOrderCellType?
    {
        didSet {
            guard let type = type else {return}
            switch type {
            case .toBeCompelete:
                title = "待完成订单"
            case .toBeRepayments:
                title = "待还款订单"
            case .all:
                title = "全部订单"
            }
        }
    }
    
    var dataSource = [OrderData]()
    let tableView = BaseTableView()
    let defaultOrderView = DefaultOrderView()
    
    override func initUserInterface() {
        super.initUserInterface()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        defaultOrderView.isHidden = true
        view.addSubview(defaultOrderView)
        defaultOrderView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    override func initDataSource() {
        super.initDataSource()
        RequestOfMineModel.requestMineOrders(status: nil, callback: { data in
            if data.count == 0 {
                self.defaultOrderView.isHidden = false
            } else {
                self.dataSource = data
                self.tableView.reloadData()
            }
        })
    }
}

extension AllOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .toBeCompelete {
            return 4
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.mm_reuseCell(indexPath) as OrderCommonCell
        cell.orderData = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? OrderCommonCell {
            if type == .toBeRepayments {
                let vc = RepaymentsDetailViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let orderDetailVC = OrderDetailViewController()
                orderDetailVC.loanNo = dataSource[indexPath.row].loanNo
                navigationController?.pushViewController(orderDetailVC, animated: true)
            }
        }
//        let webVc = BaseWebViewController()
//        webVc.urlString = "https://www.bestsign.info/openpagepp/getSignPageSignimagePc.json?mid=f63cc611d9054d0891e1808c37223c6d&sign=rY3CZdLf7mIJuHaHW7yKESuc4bGXDaATT83a5vA1c8x1h8WNtRkXPBOwZpNVEwdrWj3YE%2Bh4Vhbldp46NRY9IjQxgjjhwxArj70VjtMcG%2B6IY63K1XPgr%2FqtQzOneoJvfpi6TalgdulOpLw3RNZVpWXoKuO%2BValvT3lDitSjmFs%3D&fsid=1514862752669ADJ42&Coordinatelist=[{signy=0.2, signType=22200002, pagenum=6, signx=0.16}]&typedevice=2&email=805918598@qq.com&returnurl=http://47.96.37.167:8080/contract-service/anon/ssqian/callback"
//        self.navigationController?.pushViewController(webVc, animated: true)
    }
}
