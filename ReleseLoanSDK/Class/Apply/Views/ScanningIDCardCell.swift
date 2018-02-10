//
//  ScanningIDCardViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/17.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ScanningIDCardCell: BaseTableViewCell {

    var frontCallBack: (() -> ())?
    var backCallBack: (() -> ())?
    
    var frontButton: UIButton?
    var behindButton: UIButton?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let countLabel = UILabel.init(title: "已有539万借款用户完成了实名认证", titleColor: UIColor.dark, font: UIFont.size16)
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(20)
            make.centerX.equalTo(contentView)
        }
        
        let titles = ["扫描正面", "扫描背面"]
        
        for i in 0..<titles.count {
            let scanButton = UIButton(title: titles[i], titleColor: UIColor.theme)
            scanButton.isUserInteractionEnabled = false
            scanButton.layer.borderColor = UIColor.theme.cgColor
            scanButton.layer.borderWidth = 1
            contentView.addSubview(scanButton)
            scanButton.snp.makeConstraints({ (make) in
                make.top.equalTo(contentView).offset(80)
                make.width.equalTo(Scale.width(162))
                make.height.equalTo(Scale.height(86))
                switch i {
                case 0:
                    frontButton = scanButton
                    scanButton.addTarget(self, action: #selector(frontClick), for: .touchUpInside)
                    make.left.equalTo(contentView).offset(20)
                default:
                    behindButton = scanButton
                    scanButton.addTarget(self, action: #selector(backClick), for: .touchUpInside)
                    make.right.equalTo(contentView).offset(-20)
                }
            })
        }
        
        let alertLabel = UILabel.init(title: "温馨提示： 请保持光线充足，深色背景下或手持扫描更容易识别", titleColor: UIColor.theme, font: UIFont.size12)
        contentView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo((frontButton?.snp.bottom)!).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    @objc func frontClick() {
        frontCallBack?()
    }
    
    @objc func backClick() {
        backCallBack?()
    }
}

class ScanAttachmentCell: BaseTableViewCell {
    var frontCallBack: (() -> ())?
    var backCallBack: (() -> ())?
    
    var frontButton: UIButton?
    var behindButton: UIButton?
    var frontLabel: UILabel?
    var behindLabel: UILabel?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let countLabel = UILabel(title: "上传储蓄卡照片", titleColor: UIColor.dark, font: UIFont.size16)
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(20)
        }
        
        for i in 0..<2 {
            let scanButton = UIButton(image: "shangchuan")
            scanButton.layer.borderColor = UIColor.dark.cgColor
            scanButton.layer.borderWidth = 1
            contentView.addSubview(scanButton)
            
            
            let scanLabel = UILabel(title: "上传", titleColor: UIColor.theme, font: UIFont.size16)
            contentView.addSubview(scanLabel)
            scanLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(scanButton)
                make.left.equalTo(scanButton.snp.right).offset(20)
            })
            
            let blackLabel = UILabel(title: "储蓄卡正面照片", titleColor: UIColor.dark, font: UIFont.size16)
            contentView.addSubview(blackLabel)
            blackLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(scanLabel)
                make.left.equalTo(scanLabel.snp.right)
            })
            
            scanButton.snp.makeConstraints({ (make) in
                make.top.equalTo(countLabel.snp.bottom).offset(20 + (Scale.height(100) + 40) * CGFloat(i))
                make.width.equalTo(Scale.width(118))
                make.height.equalTo(Scale.height(100))
                make.left.equalTo(contentView).offset(20)
                switch i {
                case 0:
                    frontButton = scanButton
                    frontLabel = scanLabel
                    scanButton.addTarget(self, action: #selector(frontClick), for: .touchUpInside)
                    blackLabel.text = "储蓄卡正面照片"
                default:
                    behindButton = scanButton
                    behindLabel = scanLabel
                    scanButton.addTarget(self, action: #selector(backClick), for: .touchUpInside)
                    blackLabel.text = "储蓄卡背面照片"
                    make.bottom.equalTo(contentView).offset(-20)
                }
            })
        }
        
        line.isHidden = true
    }
    
    @objc func frontClick() {
        frontCallBack?()
    }
    
    @objc func backClick() {
        backCallBack?()
    }
}
