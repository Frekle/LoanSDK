//
//  DefaultOrderCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/20.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class DefaultOrderCell: BaseTableViewCell {

    override func initUserInterface() {
        super.initUserInterface()
        
        let imageView = UIImageView(name: "icon_quesheng")
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(55)
            make.bottom.equalTo(contentView).offset(-105)
        }
        
        let alertLabel = UILabel.init(title: "您暂时还没有申请任何借款哦~", titleColor: UIColor.dark, font: UIFont.size18Medium)
        contentView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(imageView.snp.bottom).offset(18)
        }
    }

}
