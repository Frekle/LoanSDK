//
//  RegisterViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/13.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

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
    
    let verifyCodeTextField = UITextField(placeholder: "验证码", textColor: UIColor.placeholder, font: UIFont.size14)
    
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "注册信任用，最高领取5万额度"
        view.backgroundColor = UIColor.orange
        
        let topLineTitleLabel = UILabel(title: "最高可借额度（元）", titleColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: 24))
        view.addSubview(topLineTitleLabel)
        topLineTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(Scale.height(40))
        }
        
        let lineAmountLabel = UILabel(title: "50,000", titleColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: 48))
        view.addSubview(lineAmountLabel)
        lineAmountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(topLineTitleLabel.snp.bottom)
        }
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor.white
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(lineAmountLabel.snp.bottom).offset(Scale.height(40))
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(view).offset(5)
        }
        
        let topLabel = UILabel()
        topLabel.setAttributeString(str: "1千元借12个月，日费用最低0.5元", border: 12)
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(Scale.height(15))
            make.centerX.equalTo(contentView)
        }
        
        contentView.addSubview(mobileTextField)
        mobileTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(10))
            make.right.equalTo(Scale.width(-10))
            make.top.equalTo(topLabel.snp.bottom).offset(Scale.height(25))
            make.height.equalTo(Scale.height(35))
        }
        
        let obtainVerifyButton =  SMSButton(time: .WhenRegister, smsButtonStyle: NormalSMSButtonStyle(enableColor: UIColor.theme, disenableColor: UIColor.grayText))
        obtainVerifyButton.didTouchUpInsideCallback = {
            self.respondsToSendSmsButton(sender: obtainVerifyButton)
        }
        contentView.addSubview(obtainVerifyButton)
        obtainVerifyButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Scale.width(90), height: Scale.height(30)))
            make.right.equalTo(mobileTextField)
            make.top.equalTo(mobileTextField.snp.bottom).offset(25)
        }
        
        verifyCodeTextField.keyboardType = .numberPad
        contentView.addSubview(verifyCodeTextField)
        verifyCodeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(10))
            make.centerY.equalTo(obtainVerifyButton)
            make.height.equalTo(Scale.height(35))
            make.right.equalTo(obtainVerifyButton.snp.left).offset(Scale.width(-20))
        }
        
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(10))
            make.right.equalTo(Scale.width(-10))
            make.top.equalTo(obtainVerifyButton.snp.bottom).offset(Scale.height(25))
            make.height.equalTo(Scale.height(35))
        }
        
        let registBtn = UIButton.themeButton(title: "我要借钱")
        registBtn.addTarget(self, action: #selector(responsedToRegistButton), for: .touchUpInside)
        view.addSubview(registBtn)
        registBtn.layer.cornerRadius = 25
        registBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Scale.height(28))
        }
        
        let agreeButton = UIButton.init(title: "阅读并接受《任信用用户协议》", titleColor: UIColor.lightGray)
        agreeButton.titleLabel?.font = UIFont.size15
        contentView.addSubview(agreeButton)
        agreeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(registBtn.snp.bottom).offset(Scale.height(15))
        }
        
        let loginBtn = UIButton()
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(agreeButton.snp.bottom).offset(Scale.height(25))
        }
        loginBtn.addTarget(self, action: #selector(respondToLogin), for: .touchUpInside)
        loginBtn.setAttributeString(str: "已注册用户点击登录", border: 6, font: UIFont.size14)
        
        let companyLabel = UILabel(title: "深圳博雅成信金融有限公司\nCopyright © 2015-2016 Boyacx.All Rights Reserved.", titleColor: UIColor.lightGray, font: UIFont.size14)
        companyLabel.textAlignment = .center
        companyLabel.numberOfLines = 2
        contentView.addSubview(companyLabel)
        companyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(view).offset(-10)
        }
    }

    @objc func respondsToSendSmsButton(sender: SMSButton) {
        
        let mobile = mobileTextField.text ?? ""
        if mobile.isValidPhoneNumber {
            UserSystemViewModel.sendSms(phone: mobile, callBack: { (data) in
                sender.beginAnimated()
            }, failCallback: {
                sender.toNormalState()
            })
        } else {
            sender.toNormalState()
            view.showHUD("手机号不正确")
        }

    }
    
    @objc func responsedToRegistButton() {
        guard let verifyCode = verifyCodeTextField.text else{return view.showHUD("输入验证码")}
        guard let mobile     = mobileTextField.text else{return view.showHUD("输入手机号")}
        guard let password   = passwordTextField.text else {return view.showHUD("输入密码")}
        
        guard mobile.isValidPhoneNumber == true else {
            return view.showHUD("手机号不正确")
        }
        
        guard password.isValidLoginPassword == true else {
            return view.showHUD("密码至少为8位字符，必须包含数字，字符，符号任意两种")
        }
        
        guard verifyCode.isEmpty == false else {
            return view.showHUD("请输入验证码")
        }
        
        UserSystemViewModel.registe(userName: mobile, password: password, verifyword: verifyCode) { (data) in
            // 存储用户信息
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        }
    }
    
    @objc func respondToLogin() {
        self.navigationController?.popViewController(animated: true)
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
}
