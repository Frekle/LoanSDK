//
//  BaseTableView.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

//    override init() {
//        super.init()
//    }
    
    var addAccountCallback: (() -> ())?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showEmptyCart() {
        self.removeNoDataView()
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self)
        }
        objc_setAssociatedObject(self, &k_noGood, contentView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let cartImageView = UIImageView(name: "icon_qianyuewancheng")
        contentView.addSubview(cartImageView)
        cartImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(Scale.height(100))
        }
        
        let goHomeButton = UIButton(title: "点击添加还款账户", titleColor: UIColor.theme, font: UIFont.systemFont(ofSize: 20))
        goHomeButton.addTarget(self, action: #selector(responsedToAddAccount), for: .touchUpInside)
        contentView.addSubview(goHomeButton)
        goHomeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(cartImageView.snp.bottom).offset(Scale.height(25))
        }
    }
    
    @objc func responsedToAddAccount() {
        addAccountCallback?()
    }
}
