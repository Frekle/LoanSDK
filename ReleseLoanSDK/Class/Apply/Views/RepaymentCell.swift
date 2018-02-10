//
//  RepaymentCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class RepaymentCell: BaseTableViewCell {

    override func initUserInterface() {
        super.initUserInterface()
        
        let titleLabel = UILabel.init(title: "还款金额", titleColor: UIColor.dark, font: UIFont.size18Medium)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(Scale.width(20))
            make.top.bottom.equalTo(contentView)
            make.height.equalTo(60)
        }
        
        let detailLabel = UILabel(title: "12个月", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(Scale.width(50))
            make.centerY.equalTo(contentView)
        }
        
        let rightArrow = UIImageView(name: "nav_btn_youjiantou_normal")
        contentView.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-Scale.width(20))
        }
        
//        contentView.snp.updateConstraints { (make) in
//            make.height.equalTo(60)
//        }
    }

}
