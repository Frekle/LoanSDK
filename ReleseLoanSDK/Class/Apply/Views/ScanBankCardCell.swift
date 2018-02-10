//
//  ScanBankCardCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

enum ScanBankCardCellType {
    case cardNumber
    case rightText
    case rightField
}

class ScanBankCardCell: CommonTextCell {

    var type: ScanBankCardCellType = .rightText {
        didSet {
            switch type {
            case .rightText:
                inputTextfield.isHidden = true
                cardNumberTextfield.isHidden = true
            case .rightField:
                detailLabel.isHidden = true
                inputTextfield.isHidden = false
                cardNumberTextfield.isHidden = true
                rightArrow.isHidden = true
            case .cardNumber:
                scanButton.isHidden = false
                cardNumberTextfield.isHidden = false
                detailLabel.isHidden = true
                inputTextfield.isHidden = true
                rightArrow.isHidden = true
            }
        }
    }
    
    let detailLabel = UILabel.init(title: "请选择", titleColor: UIColor.lightGray, font: UIFont.size14)
    let inputTextfield = UITextField.init(placeholder: "请输入", textColor: UIColor.lightGray, font: UIFont.size14)
    let cardNumberTextfield = UITextField(placeholder: "请输入您的银行卡号", textColor: UIColor.lightGray, font: UIFont.size14)
    let scanButton = UIButton(image: "btn_xiangji")
    
    var scanButtonClickedCallback: (() -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(rightArrow.snp.left).offset(Scale.width(-10))
        }
        
        inputTextfield.textAlignment = .right
        inputTextfield.isHidden = true
        contentView.addSubview(inputTextfield)
        inputTextfield.snp.makeConstraints { (make) in
            make.right.equalTo(detailLabel)
            make.height.equalTo(44)
            make.width.equalTo(contentView).multipliedBy(0.3)
        }
        
        cardNumberTextfield.isHidden = true
        contentView.addSubview(cardNumberTextfield)
        cardNumberTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(commonLabel.snp.right).offset(45)
            make.height.equalTo(44)
            make.width.equalTo(contentView).multipliedBy(0.5)
        }
        
        scanButton.isHidden = true
        scanButton.addTarget(self, action: #selector(responsedToScanButton), for: .touchUpInside)
        contentView.addSubview(scanButton)
        scanButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
        }
    }
    
    @objc func responsedToScanButton() {
        scanButtonClickedCallback?()
    }
}
