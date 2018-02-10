//
//  OrderCommonCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/20.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class OrderCommonCell: BaseTableViewCell {
    
    var orderData: OrderData? {
        didSet {
            guard let data = orderData else{return}
            numberLabel.text = "申请额度\(data.loanAmt)元"
            limitLabel.text = "还款期限\(data.instNum)个月"
            timeLabel.text = "\(data.applyDate/1000)".timeSince1970(dateFormat: "YYYY-MM-dd")
            statusLabel.text = " \(OrderStatus(rawValue: Int(data.stat) ?? 0)?.stringValue ?? "") "
        }
    }
    
    let numberLabel = UILabel.init(title: "申请额度2000元", titleColor: UIColor.dark, font: UIFont.size16)
    let statusLabel = UILabel.init(title: "审批中", titleColor: UIColor.white, font: UIFont.size12)
    let limitLabel = UILabel.init(title: "还款期限12个月", titleColor: UIColor.dark, font: UIFont.size16)
    let timeLabel = UILabel.init(title: "2017-12-22", titleColor: UIColor.lightGray, font: UIFont.size12)
    let applyCountLabel = UILabel(title: "1235人申请", titleColor: UIColor.lightGray, font: UIFont.size12)

    override func initUserInterface() {
        super.initUserInterface()
        let logoView = UIImageView(name: "pic_dengluye_logo")
        contentView.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(15)
            make.height.width.equalTo(22)
        }
        
        let titleLabel = UILabel.init(title: "信任用", titleColor: UIColor.dark, font: UIFont.size18Medium)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(logoView)
            make.left.equalTo(logoView.snp.right)
        }
        
        
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(44)
            make.bottom.equalTo(contentView).offset(-34)
            make.left.equalTo(contentView).offset(20)
        }
        
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).offset(-14)
        }
        
        
        contentView.addSubview(limitLabel)
        limitLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(numberLabel)
        }
        
        statusLabel.backgroundColor = UIColor.theme
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(16)
        }
        
        applyCountLabel.isHidden = true
        contentView.addSubview(applyCountLabel)
        applyCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel)
            make.right.equalTo(contentView).offset(-20)
        }
    }

}


