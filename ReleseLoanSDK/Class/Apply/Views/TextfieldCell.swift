//
//  TextfieldCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class TextfieldCell: BaseTableViewCell {

    let verifyTextfield = UITextField(placeholder: "请输入验证码", textColor: UIColor.lightGray, font: UIFont.size14)
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(verifyTextfield)
        verifyTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(40)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(44)
        }
    }

}
