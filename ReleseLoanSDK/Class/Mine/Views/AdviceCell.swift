//
//  AdviceCell.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class AdviceCell: BaseTableViewCell {
    
//    let placeholder = UILabel.init(title: "请详细描述你使用过程中遇到的问题", titleColor:UIColor.lightGray, font: UIFont.size18)
    var placeholder: UILabel?
    var commitCallback: (()->())?

    override func initUserInterface() {
        super.initUserInterface()
        
        let textView = UITextView()
        textView.layer.borderColor = UIColor.line.cgColor
        textView.layer.borderWidth = Screen.onePX
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.font = UIFont.size18
        textView.delegate = self
        contentView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(200)
        }
        
        let placeholder = UILabel(title: "请详细描述你使用过程中遇到的问题", titleColor:UIColor.lightGray, font: UIFont.size18)
        self.placeholder = placeholder
        textView.addSubview(placeholder)
        placeholder.snp.makeConstraints { (make) in
            make.left.equalTo(textView).offset(5)
            make.top.equalTo(textView).offset(7)
        }
        
        let addImgButton = UIButton(image: "btn_shangchuanjietu")
        contentView.addSubview(addImgButton)
        addImgButton.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.left.equalTo(textView)
        }
        
        let alertLabel = UILabel.init(title: "上传问题截图（选填）", titleColor: UIColor.lightGray, font: UIFont.size18)
        contentView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(addImgButton)
            make.left.equalTo(addImgButton.snp.right).offset(20)
        }
        
        let commitButton = UIButton.themeButton(title: "提交")
        commitButton.addTarget(self, action: #selector(respondToCommitButton), for: .touchUpInside)
        contentView.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.top.equalTo(addImgButton.snp.bottom).offset(30)
            make.left.right.equalTo(textView)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView)
        }
        
        line.isHidden = true
    }

    @objc func respondToCommitButton() {
        commitCallback?()
    }
}

extension AdviceCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            placeholder?.isHidden = true
        } else {
            placeholder?.isHidden = false
        }
    }
}
