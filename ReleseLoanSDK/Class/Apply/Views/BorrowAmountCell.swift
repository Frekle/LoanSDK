//
//  BorrowAmountCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class BorrowAmountCell: BaseTableViewCell {

    let inputTF = UITextField(placeholder: "", textColor: UIColor.dark, font: UIFont.boldSystemFont(ofSize: 40))
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let titleLabel = UILabel.init(title: "借款金额", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(Scale.height(10))
            make.left.equalTo(contentView).offset(Scale.width(20))
        }
        
        let moneyLabel = UILabel.init(title: "￥", titleColor: UIColor.dark, font: UIFont.boldSystemFont(ofSize: Scale.height(50)))
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Scale.height(20))
            make.left.equalTo(contentView).offset(Scale.width(20))
            make.height.equalTo(Scale.height(50))
            make.bottom.equalTo(contentView).offset(-Scale.height(20))
        }
        
        inputTF.text = "10000"
        inputTF.keyboardType = .numberPad
        contentView.addSubview(inputTF)
        inputTF.snp.makeConstraints { (make) in
            make.bottom.equalTo(moneyLabel)
            make.left.equalTo(moneyLabel.snp.right).offset(10)
            make.width.equalTo(Screen.width).multipliedBy(0.5)
            make.height.equalTo(Scale.height(40))
        }
        
    }
    
}
