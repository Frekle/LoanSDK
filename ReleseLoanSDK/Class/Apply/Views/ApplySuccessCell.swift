//
//  ApplySuccessCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ApplySuccessCell: BaseTableViewCell {

    var responseToBackBlock: (() -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let successImageView = UIImageView.init(name: "icon_shenqingwancheng")
        contentView.addSubview(successImageView)
        successImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(Scale.height(65))
        }

        let successLabel = UILabel.init(title: "申请成功，预计XX小时内放款，请注意查收短\n信，稍后可能会有审核经理会电话联系您。\n请保持电话畅通，祝生活愉快~", titleColor: UIColor.dark, font: UIFont.size14)
        successLabel.numberOfLines = 0
        contentView.addSubview(successLabel)
        successLabel.snp.makeConstraints { (make) in
            make.top.equalTo(successImageView.snp.bottom).offset(25)
            make.centerX.equalTo(contentView)
        }
        
        let loginBtn = UIButton.themeButton(title: "返回首页")
        loginBtn.addTarget(self, action: #selector(backHome), for: .touchUpInside)
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(successLabel.snp.bottom).offset(Scale.height(25))
            make.bottom.equalTo(contentView)
        }
        
        line.isHidden = true
    }
    
    @objc func backHome() {
        responseToBackBlock?()
    }

}
