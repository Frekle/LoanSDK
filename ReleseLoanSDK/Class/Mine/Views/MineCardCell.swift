//
//  MIneCardCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class MineCardCell: BaseTableViewCell {

    var myCardData: MyBankCardData? {
        didSet {
            guard let myCardData = myCardData else {return}
            var acctNo = myCardData.acctNo
            if acctNo.count >= 4 {
                acctNo = acctNo.substringFromIndex(index: acctNo.count - 4)
            }
            nameLabel.text = myCardData.openOrg + "(\(acctNo))"
            phoneLabel.text = myCardData.acctName
        }
    }
    
    let nameLabel = UILabel(title: "银行", titleColor: UIColor.dark, font: UIFont.size18Medium)
    let phoneLabel = UILabel(title: "姓名", titleColor: UIColor.dark, font: UIFont.size16)
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let imgV = UIImageView(name: "icon_touxiang")
        contentView.addSubview(imgV)
        imgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgV)
            make.left.equalTo(imgV.snp.right).offset(Scale.width(20))
        }
        
        contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgV)
            make.left.equalTo(nameLabel)
        }
        
        let image = UIImage(named: "nav_btn_youjiantou_normal")
        let rightArrow = UIImageView()
        rightArrow.image = image
        rightArrow.tintColor = UIColor.white
        contentView.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-Scale.width(20))
        }
    }

}
