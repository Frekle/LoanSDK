//
//  OrderCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

public enum MineOrderCellType: Int {
    case toBeCompelete = 100
    case toBeRepayments
    case all
}

class MineOrderCell: BaseTableViewCell {

    var responsedToOrderButtoncallBack: ((MineOrderCellType) -> ())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        let imageList = ["btn_daiwancheng", "btn_daihuankuan", "btn_quanbudingdan"]
        let titleList = ["待完成", "待还款", "全部订单"]
        
        for i in 0..<imageList.count {
            let imgV = UIButton(image: imageList[i])
            imgV.addTarget(self, action: #selector(responsedToOrderButton), for: .touchUpInside)
            imgV.tag = 100 + i
            contentView.addSubview(imgV)
            imgV.snp.makeConstraints { (make) in
                make.top.equalTo(contentView).offset(9)
                switch i {
                case 0:
                    make.left.equalTo(contentView).offset(Scale.width(56))
                case 1:
                    make.centerX.equalTo(contentView)
                default:
                    make.right.equalTo(contentView).offset(Scale.width(-56))
                }
                
            }
            
            let orderLabel = UILabel(title: titleList[i], titleColor: UIColor.dark, font: UIFont.size16Medium)
            contentView.addSubview(orderLabel)
            orderLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imgV.snp.bottom).offset(5)
                make.centerX.equalTo(imgV)
            }
        }
    }
    
    @objc func responsedToOrderButton(sender: UIButton) {
        if let tag = MineOrderCellType(rawValue: sender.tag) {
            responsedToOrderButtoncallBack?(tag)
        }
    }

}
