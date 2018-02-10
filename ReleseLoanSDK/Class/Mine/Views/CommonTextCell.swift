//
//  CommonTextCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CommonTextCell: BaseTableViewCell {

    let commonLabel = UILabel(title: "", titleColor: UIColor.dark, font: UIFont.size16Medium)
    let rightArrow = UIImageView(name: "nav_btn_youjiantou_normal")
    
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(commonLabel)
        commonLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
        }
        
        contentView.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
        }
    }

}
