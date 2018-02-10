//
//  RepaymentsDetailViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/21.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class RepaymentsDetailViewController: BaseViewController {
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "待还款订单"
        
        let tableView = BaseTableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}

extension RepaymentsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.mm_reuseCell(indexPath) as OrderDetailTopTableViewCell
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as TextAndDetailCell
            cell.line.isHidden = true
            cell.detailLabel.snp.remakeConstraints({ (make) in
                make.right.equalTo(cell.rightArrow)
                make.centerY.equalTo(cell.contentView)
            })
            switch indexPath.row {
            case 0, 1:
                cell.commonLabel.text = "已还0期"
                cell.commonLabel.textColor = UIColor.dark
                cell.commonLabel.font = UIFont.size18
            case 2:
                cell.commonLabel.text = "2018/01/09"
                cell.commonLabel.textColor = UIColor.dark
                cell.commonLabel.font = UIFont.size14
            default:
                cell.commonLabel.text = "2018/01/09"
                cell.commonLabel.textColor = UIColor.placeholder
                cell.commonLabel.font = UIFont.size14
            }
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.view
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
