//
//  CertificationCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CertificationCell: BaseTableViewCell {

    var couldPush = true {
        didSet {
            rightArrow.isHidden = !couldPush
            detailLabel.isHidden = !couldPush
        }
    }
    
    let sortImageView = UIImageView()
    let sortLabel = UILabel.init(title: "", titleColor: UIColor.dark, font: UIFont.size16Medium)
    
    let rightArrow = UIImageView(name: "nav_btn_youjiantou_normal")
    let detailLabel = UILabel.init(title: "", titleColor: UIColor.lightGray, font: UIFont.size14)
    let inputTextfield = UITextField.init(placeholder: "请输入", textColor: UIColor.lightGray, font: UIFont.size14)
    let marrySwitch = UISegmentedControl(items: ["已婚", "未婚"])
    
    var selectedMarriageItem: ((String) -> Void)?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        contentView.addSubview(sortImageView)
        sortImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(Scale.width(20))
        }
        
        contentView.addSubview(sortLabel)
        sortLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(sortImageView).offset(Scale.width(30))
        }
        
        contentView.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-Scale.width(20))
        }
        
        detailLabel.textAlignment = .right
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(rightArrow.snp.left).offset(Scale.width(-10))
            make.width.equalTo(Screen.width / 2)
        }
        
        inputTextfield.textAlignment = .right
        inputTextfield.isHidden = true
        contentView.addSubview(inputTextfield)
        inputTextfield.snp.makeConstraints { (make) in
            make.right.equalTo(detailLabel)
            make.height.equalTo(44)
            make.width.equalTo(contentView).multipliedBy(0.5)
        }
        
        marrySwitch.selectedSegmentIndex = 0
        marrySwitch.isHidden = true
        marrySwitch.tintColor = UIColor.lightTheme
//        marrySwitch.backgroundColor = UIColor.theme
        marrySwitch.addTarget(self, action: #selector(responsedToSwitch), for: .valueChanged)
        contentView.addSubview(marrySwitch)
        marrySwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.width.equalTo(120)
            make.height.equalTo(20)
            make.right.equalTo(rightArrow)
        }
        
        marrySwitch.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.lightGray], for: .normal)
//        marrySwitch.setImage(UIImage.imageWithColor(UIColor.theme), forSegmentAt: 0)
    }
    
    @objc func responsedToSwitch(sender: UISegmentedControl) {
        
        selectedMarriageItem?(["已婚", "未婚"][sender.selectedSegmentIndex])
//        sender.isOn =
//        debugLog(sender.selectedSegmentIndex)
    }

}

//class FKSegmentController: UIView {
//
//    convenience init(items: [Any]) {
//        self.init()
//        initUserInterface()
//    }
//
//    func initUserInterface() {
//        let item = UIButton.init(title: "已婚", titleColor: <#T##UIColor#>, image: <#T##String#>)
//    }
//}

