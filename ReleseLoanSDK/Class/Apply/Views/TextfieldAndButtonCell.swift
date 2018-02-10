//
//  TextfieldAndButtonCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class TextfieldAndButtonCell: CommonTextCell {

    let verifyTextfield = UITextField(placeholder: "请输入验证码", textColor: UIColor.lightGray, font: UIFont.size14)
    fileprivate let verifyButton = SMSButton(time: .WhenAddNewUser, smsButtonStyle: NormalSMSButtonStyle(enableColor: UIColor.theme, disenableColor: UIColor.grayText))
    var respondToVertifyButtonCallback:((SMSButton) -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        commonLabel.text = "验证码"
        rightArrow.isHidden = true
        
        contentView.addSubview(verifyTextfield)
        verifyTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(100)
            make.height.equalTo(44)
            make.width.equalTo(contentView).multipliedBy(0.35)
        }
        
        verifyButton.didTouchUpInsideCallback = {
            self.respondToVertifyButtonCallback?(self.verifyButton)
        }
        contentView.addSubview(verifyButton)
        verifyButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(Scale.height(30))
            make.width.equalTo(Scale.width(90))
        }
    }

}
