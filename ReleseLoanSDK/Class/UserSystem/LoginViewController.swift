//
//  LoginViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/12.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

public class LoginViewController: BaseViewController {

    let PhoneMaxLength = 11
    let PasswordMaxlength = 16
    
    lazy var mobileTextField: UITextField = {
        let mobileImageView = UIImageView(name: "icon_shoujihaoma_normal")
        mobileImageView.frame = CGRect(x: 0, y: 0, width: 16, height: 23)
        let mobileTextField = UITextField.init(placeholder: "请输入本人常用手机号", rightImageView: mobileImageView)
        mobileTextField.keyboardType = .phonePad
        return mobileTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        let lockImageView = UIImageView(name: "icon_mima_normal")
        lockImageView.frame = CGRect(x: 0, y: 0, width: 16, height: 23)
        let passwordTextField = UITextField.init(placeholder: "请输入密码", rightImageView: lockImageView)
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
//    let verifyCodeTextField = UITextField(placeholder: "验证码", textColor: UIColor.placeholder, font: UIFont.size14)
    
    override func initUserInterface() {
        super.initUserInterface()
        view.backgroundColor = UIColor.white

        title = "登录"
        
        //logo
        let logoIV = UIImageView(name: "pic_dengluye_logo")
        view.addSubview(logoIV)
        logoIV.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.centerX.equalTo(view)
        }
        
        let logoTitle = UILabel(title: "信任用升级版", titleColor: UIColor.dark, font: UIFont.size18)
        view.addSubview(logoTitle)
        logoTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(logoIV)
            make.top.equalTo(logoIV.snp.bottom).offset(Scale.height(12))
        }
        
        
        view.addSubview(mobileTextField)
        mobileTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(20))
            make.right.equalTo(Scale.width(-20))
            make.top.equalTo(logoTitle.snp.bottom).offset(Scale.height(45))
            make.height.equalTo(Scale.height(35))
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(mobileTextField)
            make.right.equalTo(mobileTextField)
            make.top.equalTo(mobileTextField.snp.bottom).offset(Scale.height(25))
            make.height.equalTo(Scale.height(35))
        }
        
        let loginBtn = UIButton.themeButton(title: "登录")
        loginBtn.addTarget(self, action: #selector(respondsToLoginButton), for: .touchUpInside)
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Scale.height(45))
        }
        
        let forgetBtn = UIButton(title: "忘记密码")
        forgetBtn.setTitleColor(UIColor.dark, for: .normal)
        forgetBtn.titleLabel?.font = UIFont.size14
        forgetBtn.addTarget(self, action: #selector(responseToForgetButton), for: .touchUpInside)
        view.addSubview(forgetBtn)
        forgetBtn.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
        }
        
        let registerBtn = UIButton(title: "免费注册")
        registerBtn.setTitleColor(UIColor.dark, for: .normal)
        registerBtn.titleLabel?.font = UIFont.size14
        registerBtn.addTarget(self, action: #selector(respondsToRegisteButton), for: .touchUpInside)
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.right.equalTo(loginBtn)
            make.centerY.equalTo(forgetBtn)
        }

//        mobileTextField.text = "18380448164"
//        mobileTextField.text = "13688406440"
//        passwordTextField.text = "1234567"
//        passwordTextField.text = "w1234567"
    }

    @objc func backViewClicked() {
        view.endEditing(true)
    }

    @objc func respondsToLoginButton() {
        
        view.endEditing(true)
        guard let phone = mobileTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        guard phone.isValidPhoneNumber else {
            view.showHUD("手机号不正确")
            return
        }
        guard password.isValidLoginPassword else {
            view.showHUD("密码至少为8位字符，必须包含数字，字符，符号任意两种")
            return
        }
        
        UserSystemViewModel.login(phone: phone, passwd: password) {
            if let user = UserInfo.shared().user {
                if user.certificationed {
                    UIApplication.shared.keyWindow?.rootViewController = TabBarViewController()
                } else {
                    self.navigationController?.pushViewController(CertificationViewController(), animated: true)
                }
            }
        }
    }

    @objc func respondsToRegisteButton() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

    @objc func responseToForgetButton() {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc func timerMothed(_ timer:Timer) {
        let btn = (timer.userInfo as! NSDictionary)["btn"] as! UIButton
        btn.setTitle("已发送(\(UserSystemViewModel.VerificationCodeCountdown))", for: UIControlState.normal)
        btn.setTitleColor(UIColor.theme, for: UIControlState.normal)
        btn.isEnabled = false
        UserSystemViewModel.VerificationCodeCountdown -= 1
        if UserSystemViewModel.VerificationCodeCountdown <= 0 {
            timer.invalidate()
            btn.setTitle("重新发送", for: UIControlState.normal)
            btn.setTitleColor(UIColor.wlYellow, for: UIControlState.normal)
            btn.isEnabled = true
        }
    }

    @objc func textDidChange(sender: UITextField) {

        let maxLength = sender == mobileTextField ? PhoneMaxLength: PasswordMaxlength
        
        if (sender.text?.count ?? 0) >= maxLength {
            guard let startIndex = sender.text?.startIndex else {return}
            guard let index = sender.text?.index(startIndex, offsetBy: maxLength) else { return }
            sender.text = sender.text?.substring(to: index)
        }
    }
}
