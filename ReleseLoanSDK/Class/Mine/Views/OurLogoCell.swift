//
//  OurLogoCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class OurLogoCell: BaseTableViewCell {

    override func initUserInterface() {
        super.initUserInterface()
        
        //logo
        let logoIV = UIImageView(name: "pic_dengluye_logo")
        contentView.addSubview(logoIV)
        logoIV.snp.makeConstraints { (make) in
            make.top.equalTo(35)
            make.centerX.equalTo(contentView)
        }
        
        let logoTitle = UILabel(title: "V2.2.1", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(logoTitle)
        logoTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(logoIV)
            make.top.equalTo(logoIV.snp.bottom).offset(15)
            make.bottom.equalTo(contentView).offset(-40)
        }
    }

}
