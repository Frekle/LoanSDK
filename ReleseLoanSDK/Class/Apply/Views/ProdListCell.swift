//
//  ProdListCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/5.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ProdListCell: BaseTableViewCell {
    
    var dataSource: ProdData? {
        didSet {
            periodLabel.text = "\(dataSource?.instNum ?? 0)"
            moneyLabel.text = String(format: "%.2f", dataSource?.mthAmt ?? 0)
            dateLabel.text = dataSource?.busiDate
        }
    }

    let periodLabel = UILabel(title: "", titleColor: UIColor.dark, font: UIFont.size14)
    let moneyLabel = UILabel(title: "", titleColor: UIColor.dark, font: UIFont.size14)
    let dateLabel = UILabel(title: "", titleColor: UIColor.dark, font: UIFont.size14)
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(periodLabel)
        periodLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
//            make.left.equalTo(contentView)
            make.centerX.equalTo(contentView).multipliedBy(0.25)
        }
        
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).multipliedBy(1.75)
//            make.right.equalTo(contentView)
        }
        
    }

}
