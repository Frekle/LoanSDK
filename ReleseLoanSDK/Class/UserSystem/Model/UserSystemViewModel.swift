//
//  UserSystemViewModel.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/18.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

struct UserSystemViewModel {
    static var VerificationCodeCountdown = 60
    
    static func registe(userName: String, password: String,verifyword:String, callBack: @escaping (RegisterModel) -> Void) {
        NetWorkManager.request(api: .regist(username: userName, password: password, verifyword: verifyword), successHandler: { (data: BaseModel<RegisterModel>) in
            guard let userData = data.data else{return}
            CachedData.saveLocalData(CachedData.registKey, value: userData)
            callBack(userData)
        }) { (error) in
        }
    }
    
    static func sendSms(phone: String, callBack: @escaping (SMSModel) -> Void, failCallback: @escaping () -> ()) {
        NetWorkManager.request(api: .sendSms(phone: phone), successHandler: { (data: BaseModel<SMSModel>) in
            guard let userData = data.data else{return}
            callBack(userData)
        }) { (error) in
            failCallback()
        }
        
    }
    
    static func login(phone: String, passwd: String, callBack: @escaping () -> ()) {
        
        NetWorkManager.request(api: Api.login(phone: phone, passwd: passwd, loginType: "24200004", applyType: "25800002", sourceOsType: "30500017", imei: Keychain().UUIDString), successHandler: { (data: BaseData) in
            if data.resultString == "0000" {
                callBack()
            }
        }) { (error) in
        }
    }
    
    static func forgetPassword(phone: String, password: String, verifyCode: String, callBack: @escaping (FindPasswordModel) -> Void) {
        NetWorkManager.request(api: Api.findPassword(phone: phone, passwd: password, verifyCode: verifyCode), successHandler: { (data: BaseModel<FindPasswordModel>) in
            guard let userData = data.data else{return}
            callBack(userData)
        }) { (error) in
            
        }
    }
}
