//
//  ApplyStepsCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ApplyStepsCell: BaseTableViewCell {

    let stepsImageView = UIImageView(name: "pic_buzhou1")
    
    override func initUserInterface() {
        super.initUserInterface()
        
        
        contentView.addSubview(stepsImageView)
        stepsImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(Scale.height(15))
            make.width.equalTo(Scale.width(335))
            make.height.equalTo(Scale.height(60))
        }
        
        let step1Label = UILabel.init(title: "申请人资质", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(step1Label)
        step1Label.snp.makeConstraints { (make) in
            make.top.equalTo(stepsImageView.snp.bottom).offset(14)
            make.left.equalTo(contentView).offset(Scale.width(15))
            make.bottom.equalTo(contentView).offset(Scale.height(-15))
        }
        
        let step2Label = UILabel.init(title: "借款金额", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(step2Label)
        step2Label.snp.makeConstraints { (make) in
            make.top.equalTo(stepsImageView.snp.bottom).offset(14)
            make.left.equalTo(step1Label.snp.right).offset(Scale.width(25))
        }
        
        
        let step4Label = UILabel.init(title: "申请完成", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(step4Label)
        step4Label.snp.makeConstraints { (make) in
            make.top.equalTo(stepsImageView.snp.bottom).offset(14)
            make.right.equalTo(contentView).offset(Scale.width(-20))
        }
        
        let step3Label = UILabel.init(title: "认证资料", titleColor: UIColor.dark, font: UIFont.size14)
        contentView.addSubview(step3Label)
        step3Label.snp.makeConstraints { (make) in
            make.top.equalTo(stepsImageView.snp.bottom).offset(14)
            make.right.equalTo(step4Label.snp.left).offset(Scale.width(-38))
        }
    }

}
