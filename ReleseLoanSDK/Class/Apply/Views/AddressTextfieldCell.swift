//
//  AddressTextfieldCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class AddressTextfieldCell: BaseTableViewCell {

    let textfield = UITextField.init(placeholder: "请填写详细地址", textColor: UIColor.lightGray, font: UIFont.size14)
    
    override func initUserInterface() {
        super.initUserInterface()
    
        contentView.addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(Scale.width(45))
        }
    }

}
