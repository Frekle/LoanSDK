//
//  HomeBorrowingCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class HomeBorrowingCell: BaseTableViewCell {

    var responseToBackBlock: (() -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let highestTitleLabel = UILabel(title: "最高额度", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(highestTitleLabel)
        highestTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(Scale.height(50))
            make.centerX.equalTo(contentView).multipliedBy(0.5)
        }
        
        let highestAmountLabel = UILabel(title: "￥50,000", titleColor: UIColor.theme, font: UIFont.boldSystemFont(ofSize: 20))
        contentView.addSubview(highestAmountLabel)
        highestAmountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(highestTitleLabel.snp.bottom).offset(Scale.height(20))
            make.centerX.equalTo(highestTitleLabel)
        }
        
        let limitTitleLabel = UILabel(title: "最长期限", titleColor: UIColor.dark, font: UIFont.size18)
        contentView.addSubview(limitTitleLabel)
        limitTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(Scale.height(50))
            make.centerX.equalTo(contentView).multipliedBy(1.5)
        }
        
        let limitAmountLabel = UILabel(title: "18个月", titleColor: UIColor.theme, font: UIFont.boldSystemFont(ofSize: 20))
        contentView.addSubview(limitAmountLabel)
        limitAmountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(limitTitleLabel.snp.bottom).offset(Scale.height(20))
            make.centerX.equalTo(limitTitleLabel)
        }
        
        let loginBtn = UIButton.themeButton(title: "立即借款")
        loginBtn.addTarget(self, action: #selector(backHome), for: .touchUpInside)
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(highestAmountLabel.snp.bottom).offset(Scale.height(35))
            make.bottom.equalTo(contentView)
        }
        
        line.isHidden = true
    }
    
    @objc func backHome() {
        responseToBackBlock?()
    }

}
