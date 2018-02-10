//
//  ForgotPasswordViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/13.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

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
        
        title = "找回登录密码"
        
        view.addSubview(mobileTextField)
        mobileTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(20))
            make.right.equalTo(Scale.width(-20))
            make.top.equalTo(Scale.height(50))
            make.height.equalTo(Scale.height(35))
        }
        
        let obtainVerifyButton =  SMSButton(time: .WhenForgetPassword, smsButtonStyle: NormalSMSButtonStyle(enableColor: UIColor.theme, disenableColor: UIColor.grayText))
        obtainVerifyButton.didTouchUpInsideCallback = {
            self.respondsToSendSmsButton(sender: obtainVerifyButton)
        }
        view.addSubview(obtainVerifyButton)
        obtainVerifyButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Scale.width(90), height: Scale.height(30)))
            make.right.equalTo(mobileTextField)
            make.top.equalTo(mobileTextField.snp.bottom).offset(25)
        }
        
        verifyCodeTextField.keyboardType = .numberPad
        view.addSubview(verifyCodeTextField)
        verifyCodeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(mobileTextField)
            make.centerY.equalTo(obtainVerifyButton)
            make.height.equalTo(Scale.height(35))
            make.right.equalTo(obtainVerifyButton.snp.left).offset(Scale.width(-20))
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(Scale.width(20))
            make.right.equalTo(Scale.width(-20))
            make.top.equalTo(obtainVerifyButton.snp.bottom).offset(Scale.height(25))
            make.height.equalTo(Scale.height(35))
        }
        
        let registBtn = UIButton.themeButton(title: "确定")
        registBtn.addTarget(self, action: #selector(responsedToRegistButton), for: .touchUpInside)
        view.addSubview(registBtn)
        registBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Scale.height(40))
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
        
        UserSystemViewModel.forgetPassword(phone: mobile, password: password, verifyCode: verifyCode) { (data) in
            self.view.showHUD(data.msg)
        }
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
