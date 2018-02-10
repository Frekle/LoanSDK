//
//  MobileOperatorViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class MobileOperatorViewController: BaseViewController {

    let leftTitle = ["手机号", "服务密码"]
    let rightInfo = ["请输入手机号", "请输入服务密码"]
    
    var mobileTF: UITextField?
    var passTF: UITextField?
    var verifyTF: UITextField?
    var operatorData: JLXMobileOperatorData?
    var type: CaptchaType = .submitQuery
    var authCallback:(()->())?
    
    var countDown = 0
    fileprivate var timer: Timer? {
        willSet {
            timer?.invalidate()
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    fileprivate func setATimer(){
        countDown = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MobileOperatorViewController.respondsToTimer(_:)), userInfo: nil, repeats: true)
        timer?.fireDate = Date.distantPast
    }
    
    @objc func respondsToTimer(_ timer : Timer){
        countDown += 1
        if countDown > 120 {
            timer.invalidate()
        }
    }
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "手机运营商"
        
        let commitButton = UIButton.bottomButton(title: "提交")
        commitButton.addTarget(self, action: #selector(responsedToCommitButton), for: .touchUpInside)
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(50)
        }
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(commitButton.snp.top)
        }
        
        
        
        let readLabel = UILabel.init(title: "我已阅读并同意《通话记录授权协议》", titleColor: UIColor.lightGray, font: UIFont.size14)
        tableView.addSubview(readLabel)
        readLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tableView).offset(150)
            make.centerX.equalTo(tableView)
        }
        
        let bottomAlertLabel = UILabel(title: "服务密码只用来验证使用，请输入正确的服务密码，以使我们核实你的身份。", titleColor: UIColor.placeholder, font: UIFont.size12)
        bottomAlertLabel.numberOfLines = 0
        tableView.addSubview(bottomAlertLabel)
        bottomAlertLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tableView).offset(20)
            make.right.equalTo(tableView).offset(-20)
            make.centerX.equalTo(tableView)
            make.top.equalTo(tableView).offset(Scale.height(480))
        }
        
        let centerAlertLabel = UILabel(title: "*资料无法提交时，若出现授权确认，请点击”允许授权“否则将无法完成后续操作。", titleColor: UIColor.dark, font: UIFont.size14)
        centerAlertLabel.numberOfLines = 0
        tableView.addSubview(centerAlertLabel)
        centerAlertLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tableView).offset(20)
            make.right.equalTo(tableView).offset(-20)
            make.centerX.equalTo(tableView)
            make.bottom.equalTo(bottomAlertLabel.snp.top).offset(-20)
        }
        
        let topAlertLabel = UILabel(title: "*手机服务密码是你的号码在中国移动，中国联通或中国电信等运营商获取读物时需要提供一个身份凭证。", titleColor: UIColor.dark, font: UIFont.size14)
        topAlertLabel.numberOfLines = 0
        tableView.addSubview(topAlertLabel)
        topAlertLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tableView).offset(20)
            make.right.equalTo(tableView).offset(-20)
            make.centerX.equalTo(tableView)
            make.bottom.equalTo(centerAlertLabel.snp.top).offset(-20)
        }
    }

    // 获取支持的数据源接口
    func getJLXDataSource(_ sender: SMSButton) {
        CertificationModel.getJLXdataSource(callback: { data in
            self.submitForm(sender)
        }, errorCallback: {
            sender.toNormalState()
        })
    }
    
    // 提交申请
    func submitForm(_ sender: SMSButton) {
        CertificationModel.submitJLXform(phone: UserInfo.shared().user?.loginNo ?? "", callback: { data in
            self.submitRequest(data: data, sender: sender)
        }, errorCallback: {
            sender.toNormalState()
        })
    }
    
    // 获取验证码: 不提交验证码
    func submitRequest(data: JLXMobileOperatorData, sender: SMSButton?, type: CaptchaType = .submit) {
        operatorData = data
        CertificationModel.submitJLXRequest(token: data.token, account: mobileTF?.text ?? "", password: passTF?.text ?? "", captcha: verifyTF?.text ?? "", website: data.datasource.website, type: .submit, callback: { success in
            if let sender = sender {
                sender.beginAnimated()
                self.setATimer()
                self.getCollectResp(data: data)
            }
        }, errorCallback: {
            sender?.toNormalState()
        })
    }
    
    
    // 获取结果
    func getCollectResp(data: JLXMobileOperatorData) {
        if timer?.isValid == false {
            return view.showHUD("请求超时")
        }
        CertificationModel.getJLXCollectResp(token: data.token, account: mobileTF?.text ?? "", password: passTF?.text ?? "", captcha: verifyTF?.text ?? "", website: data.datasource.website, type: .submit, callback: { resultData in
            switch resultData.processCode {
            case 10002, 10017, 10001, 10004, 10006, 10018:
                break
            case 10003, 10007, 10004: // 密码错误
                self.view.hidAllHud()
                self.view.showHUD(resultData.content)
            case 10022, 10023:
                self.type = .submitQuery
            case 20000:
                self.getCollectResp(data: data)
            case 30000:
                self.view.showHUD(resultData.content)
            case 0:
                self.getCollectResp(data: data)
            case 10008:
                self.view.hidAllHud()
                Window?.showHUD("认证成功")
                self.authCallback?()
                self.navigationController?.popViewController(animated: true)
            default:break
            }
        }, errorCallback: {
            
        })
    }
    
    @objc func responsedToCommitButton() {
        view.showLoading()
        guard let data = operatorData else {return view.showHUD("请先获取验证码")}
        
        submitRequest(data: data, sender: nil, type: type)
    }
}

extension MobileOperatorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 2:
            let cell = tableView.mm_reuseCell(indexPath) as TextfieldAndButtonCell
            verifyTF = cell.verifyTextfield
            cell.verifyTextfield.keyboardType = .numberPad
            cell.respondToVertifyButtonCallback = { sender in
                // 是否认证
                CertificationModel.isNeedMobileCertification(callback: { (certificationed) in
                    if certificationed {
                        sender.toNormalState()
                    } else {
                        self.getJLXDataSource(sender)
                    }
                }, errorCallback: {
                    sender.toNormalState()
                })
            }
            return cell
        default:
            let cell = tableView.mm_dequeueStaticCell(indexPath) as CreditCardCell
            cell.commonLabel.text = leftTitle[indexPath.row]
            cell.rightTextfield.placeholder = rightInfo[indexPath.row]
            if indexPath.row == 0 {
                mobileTF = cell.rightTextfield
                cell.rightTextfield.keyboardType = .phonePad
            } else if indexPath.row == 1 {
                passTF = cell.rightTextfield
                cell.rightTextfield.isSecureTextEntry = true
            }
            return cell
        }
    }
}
