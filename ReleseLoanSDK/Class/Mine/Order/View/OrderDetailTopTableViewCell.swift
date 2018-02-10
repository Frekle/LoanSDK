//
//  OrderDetailTopTableViewCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/21.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class OrderDetailTopTableViewCell: BaseTableViewCell {

    override func initUserInterface() {
        super.initUserInterface()
        
        let topContentView = UIView()
        contentView.addSubview(topContentView)
        
        
        let timeLabel = UILabel.init(title: "2017/12/09", titleColor: UIColor.dark, font: UIFont.size18)
        topContentView.addSubview(timeLabel)
        
        let numberLabel = UILabel.init(title: "借款￥5000.00", titleColor: UIColor.dark, font: UIFont.size18Medium)
        topContentView.addSubview(numberLabel)
        
        topContentView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(timeLabel)
            make.centerX.equalTo(contentView)
            make.left.equalTo(timeLabel)
            make.right.equalTo(numberLabel)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(topContentView)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(topContentView)
            make.left.equalTo(timeLabel.snp.right)
        }
        
        let phaseLabel = UILabel.init(title: "第1期，待还款", titleColor: UIColor.white, font: UIFont.size16)
        phaseLabel.textAlignment = .center
        phaseLabel.clipsToBounds = true
        phaseLabel.backgroundColor = UIColor.theme
        phaseLabel.layer.cornerRadius = 17
        contentView.addSubview(phaseLabel)
        phaseLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.height.equalTo(34)
            make.width.equalTo(134)
            make.top.equalTo(topContentView.snp.bottom).offset(20)
        }
        
        let phaseImageView = UIImageView.init(name: "pic_huankuantiao")
        contentView.addSubview(phaseImageView)
        phaseImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(phaseLabel.snp.bottom).offset(20)
        }
        
        let firstLabel = UILabel.init(title: "第1期", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(phaseImageView.snp.bottom).offset(10)
            make.centerX.equalTo(phaseImageView.snp.left)
        }
        
        let lastLabel = UILabel.init(title: "第5期", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(lastLabel)
        lastLabel.snp.makeConstraints { (make) in
            make.top.equalTo(phaseImageView.snp.bottom).offset(10)
            make.centerX.equalTo(phaseImageView.snp.right)
        }
        
        let bottomContentView = UIView()
        contentView.addSubview(bottomContentView)
        
        let thisTimeLabel = UILabel.init(title: "2017/12/09", titleColor: UIColor.dark, font: UIFont.size18)
        bottomContentView.addSubview(thisTimeLabel)
        
        let thisNumberLabel = UILabel.init(title: "第一期应还", titleColor: UIColor.dark, font: UIFont.size18Medium)
        bottomContentView.addSubview(thisNumberLabel)
        
        bottomContentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.left.equalTo(thisTimeLabel)
            make.right.equalTo(thisNumberLabel)
            make.top.equalTo(phaseImageView.snp.bottom).offset(64)
            make.height.equalTo(thisTimeLabel)
        }
        
        thisTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomContentView)
            make.right.equalTo(thisNumberLabel.snp.left)
        }
        
        thisNumberLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomContentView)
        }
        
        let priceLabel = UILabel.init(title: "￥1080.00", titleColor: UIColor.theme, font: UIFont.boldSystemFont(ofSize: 24))
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(bottomContentView.snp.bottom).offset(15)
            make.bottom.equalTo(contentView).offset(-15)
        }
    }

}
