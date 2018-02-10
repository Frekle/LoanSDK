//
//  CreditCardCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CreditCardCell: CommonTextCell {

    let rightTextfield = UITextField(placeholder: "", textColor: UIColor.lightGray, font: UIFont.size14)
    
    override func initUserInterface() {
        super.initUserInterface()
        
        rightArrow.isHidden = true
        
        rightTextfield.textAlignment = .right
        contentView.addSubview(rightTextfield)
        rightTextfield.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(44)
            make.width.equalTo(contentView).multipliedBy(0.5)
        }
    }

}
