//
//  ChangePasswordViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    lazy var passwordTextField: UITextField = {
        let lockImageView = UIImageView(name: "icon_mima_normal")
        lockImageView.frame = CGRect(x: 0, y: 0, width: 16, height: 23)
        let temp = UITextField(placeholder: "原密码", rightImageView: lockImageView)
        temp.isSecureTextEntry = true
        return temp
    }()
    
    lazy var newPasswordTextField: UITextField = {
        let newlockImageView = UIImageView(name: "icon_mima_normal")
        newlockImageView.frame = CGRect(x: 0, y: 0, width: 16, height: 23)
        let temp = UITextField(placeholder: "新密码", rightImageView: newlockImageView)
        temp.isSecureTextEntry = true
        return temp
    }()
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "修改密码"
        
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(20))
            make.right.equalTo(Scale.width(-20))
            make.top.equalTo(view)
            make.height.equalTo(60)
        }
        
        
        view.addSubview(newPasswordTextField)
        newPasswordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(20))
            make.right.equalTo(Scale.width(-20))
            make.top.equalTo(passwordTextField.snp.bottom)
            make.height.equalTo(60)
        }
        
        let loginBtn = UIButton.themeButton(title: "保存")
        loginBtn.addTarget(self, action: #selector(respondsToLoginButton), for: .touchUpInside)
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(60)
        }
    }

    @objc func respondsToLoginButton() {
        guard passwordTextField.text != "" else {
            return view.showHUD("请输入原密码")
        }
        guard newPasswordTextField.text != "" else {
            return view.showHUD("请输入新密码")
        }
        RequestOfMineModel.changePassword(oldPass: passwordTextField.text ?? "", newPass: newPasswordTextField.text ?? "") {
            Window?.showHUD("修改成功")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
