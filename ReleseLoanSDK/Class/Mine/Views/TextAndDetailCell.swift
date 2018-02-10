//
//  TextAndDetailCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/21.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class TextAndDetailCell: CommonTextCell {

    let detailLabel = UILabel.init(title: "", titleColor: UIColor.dark, font: UIFont.size14)
    
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
        }
        
        rightArrow.isHidden = true
    }

}
