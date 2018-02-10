//
//  OurInfoCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class OurInfoCell: BaseTableViewCell {

    let mainLabel = UILabel(title: "", titleColor: UIColor.dark, font: UIFont.size16Medium)
    let detailLabel = UILabel(title: "", titleColor: UIColor.lightGray, font: UIFont.size16Medium)
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(25)
        }
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(133)
        }
    }

}
