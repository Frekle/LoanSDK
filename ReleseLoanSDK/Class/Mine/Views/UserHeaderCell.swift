//
//  UserHeaderCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class UserHeaderCell: BaseTableViewCell {

    override func initUserInterface() {
        super.initUserInterface()
        
        let grandientlayer = CAGradientLayer(bounds: CGRect(x: 0, y: 0, width: Screen.width, height: 140))
        contentView.layer.insertSublayer(grandientlayer, at: 0)
        
        let imgV = UIImageView.init(name: "icon_touxiang")
        contentView.addSubview(imgV)
        imgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(35)
        }
        
        let nameLabel = UILabel(title: "高通", titleColor: UIColor.white, font: UIFont.size18)
        nameLabel.text = UserInfo.shared().user?.userName ?? ""
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgV)
            make.left.equalTo(imgV.snp.right).offset(Scale.width(20))
        }
        
        let phoneLabel = UILabel(title: "176****4662", titleColor: UIColor.white, font: UIFont.size18)
        var phone = UserInfo.shared().user?.loginNo ?? ""
        let startindex = phone.index(phone.startIndex, offsetBy: 3)
        let endIndex = phone.index(phone.startIndex, offsetBy: 7)
        phone = phone.replacingCharacters(in: startindex..<endIndex, with: "****")
        phoneLabel.text = phone
        contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgV)
            make.left.equalTo(nameLabel)
        }

        let image = UIImage(named: "nav_btn_youjiantou_normal")?.withRenderingMode(.alwaysTemplate)
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
