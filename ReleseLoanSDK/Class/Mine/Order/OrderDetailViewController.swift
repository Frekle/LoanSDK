//
//  OrderDetailViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/21.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {
    
    let leftInfo = ["订单状态", "贷款金额", "贷款期限", "月还款日", "申请时间", "月还款额"]
    var detailInfo = ["待签约", "￥5000.00", "12", "20", "2017-09-19", "￥715.00"]
    
    let leftButton = UIButton(title: "取消申请", titleColor: UIColor.white, font: UIFont.size20Medium)
    let rightButton = UIButton(title: "去签约", titleColor: UIColor.dark, font: UIFont.size20Medium)
    let tableView = BaseTableView()
    
    var status = OrderStatus.approving {
        didSet {
            switch status {
            case .notSign:
                break
            case .unpass:
                rightButton.setTitle("修改申请", for: .normal)
            default:
                leftButton.backgroundColor = UIColor.darkGray
                leftButton.isEnabled = false
                leftButton.setTitle(status.stringValue, for: .normal)
                leftButton.snp.remakeConstraints({ (make) in
                    make.left.bottom.right.equalTo(view)
                    make.height.equalTo(50)
                })
                
                rightButton.isHidden = true
            }
        }
    }

    var loanNo = "" {
        didSet {
            requestDetails()
        }
    }
    var orderDetailData: OrderDetailData? {
        didSet {
            guard let data = orderDetailData else {return}
            tableView.reloadData()
            status = OrderStatus(rawValue: Int(data.stat) ?? 0) ?? .approving
            detailInfo[0] = "\(OrderStatus(rawValue: Int(data.stat) ?? 0)?.stringValue ?? "")"
            detailInfo[1] = "￥\(data.loanAmt)"
            detailInfo[2] = "\(data.instNum)"
            detailInfo[3] = "\(data.mthRepayDate)"
            detailInfo[4] = "\(data.applyDate/1000)".time(dateFormat: "YYYY-MM-dd")
            detailInfo[5] = "￥\(data.mthRepayAmt)"
        }
    }
    
    override func initUserInterface() {
        super.initUserInterface()
        
        
        title = "订单详情"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        leftButton.backgroundColor = UIColor.theme
        leftButton.addTarget(self, action: #selector(respondToLeftButton), for: .touchUpInside)
        view.addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(view).multipliedBy(0.5)
        }
        
        rightButton.addTarget(self, action: #selector(responsedToRightButton), for: .touchUpInside)
        rightButton.layer.borderWidth = 1
        rightButton.layer.borderColor = UIColor.theme.cgColor
        view.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(view).multipliedBy(0.5)
        }
    }
    
    func requestDetails() {
        RequestOfMineModel.requestOrderDetails(loanNo: loanNo) { (orderData) in
            self.orderDetailData = orderData
        }
    }
    
    @objc func respondToLeftButton() {
        if status == .notSign {
            RequestOfMineModel.cancelApply(loanNo: loanNo) { (success) in
                if success {
                    self.navigationController?.popViewController(animated: true)
                    Window?.showHUD("取消成功")
                }
            }
        }
    }
    
    @objc func responsedToRightButton(sender: UIButton) {
        if status == .notSign {
            // 去签约
            RequestOfMineModel.getSignUrl(loanNo: loanNo) { (data) in
                let webVc = BaseWebViewController()
                webVc.urlString = data.first?.url ?? ""
                webVc.authCallback = {
                    self.requestDetails()
                }
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        } else if status == .unpass {
            UserInfo.shared().loanNo = self.loanNo
            self.navigationController?.pushViewController(CertificationViewController(), animated: true)
        }
    }
}

extension OrderDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case leftInfo.count:
            switch status {
            case .notSign:
                return 62
            case .unpass:
                return 190
            default:
                return 44
            }
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch status {
        case .unpass, .notSign:
            return leftInfo.count + 1
        default:
            return leftInfo.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case leftInfo.count:
            switch status {
            case .unpass:
                let cell = tableView.mm_reuseCell(indexPath) as CommonTextCell
                cell.rightArrow.isHidden = true
                cell.commonLabel.text = "原因:"
                cell.commonLabel.snp.remakeConstraints({ (make) in
                    make.top.left.equalTo(cell.contentView).offset(20)
                })
                return cell
            default:
                let cell = tableView.mm_reuseCell(indexPath) as CommonTextCell
                cell.line.isHidden = true
                cell.rightArrow.isHidden = true
                cell.commonLabel.textColor = UIColor.theme
                cell.commonLabel.text = "7天未签约会自动取消申请"
                return cell
            }
            
        default:
            let cell = tableView.mm_reuseCell(indexPath) as TextAndDetailCell
            cell.commonLabel.text = leftInfo[indexPath.row]
            cell.detailLabel.text = detailInfo[indexPath.row]
            return cell
        }
    }
}
