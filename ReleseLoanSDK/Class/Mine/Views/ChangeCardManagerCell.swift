//
//  ChangeCardManagerCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ChangeCardManagerCell: BaseTableViewCell {

    var responseToButtonBlock: (() -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let loginBtn = UIButton.themeButton(title: "更改还款账户")
        loginBtn.addTarget(self, action: #selector(backHome), for: .touchUpInside)
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(contentView).offset(125)
            make.bottom.equalTo(contentView)
        }
        
        line.isHidden = true
    }
    
    @objc func backHome() {
        responseToButtonBlock?()
    }

}
