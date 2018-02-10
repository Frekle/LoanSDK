//
//  UserSystemModel.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/22.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class SMSModel: BaseData {
    
    var sourceOsType = ""
    var phone = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        sourceOsType <- map["sourceOsType"]
        phone <- map["phone"]
    }
}

class RegisterModel: BaseData {
    var registSource = ""
    var password = ""
    var verifyCode = ""
    var loginNo = ""
    var loginType = ""
    var identifier = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        
        
        registSource <- map["registSource"]
        password <- map["password"]
        verifyCode <- map["verifyCode"]
        loginNo <- map["loginNo"]
        loginType <- map["loginType"]
        identifier = getUUID()
    }
    
    func getUUID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}

class LoginModel : BaseData {
    
    var loginType = ""
    var password = ""
    var loginNo = ""
    var imei = ""
    var applyType = ""
    var sourceOsType = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        loginType <- map["loginType"]
        password <- map["password"]
        loginNo <- map["loginNo"]
        imei <- map["imei"]
        applyType <- map["applyType"]
        sourceOsType <- map["sourceOsType"]
        
    }
}

class FindPasswordModel: BaseData {
    var password = ""
    var loginNo = ""
    var verifyCode = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        password <- map["password"]
        loginNo <- map["loginNo"]
        verifyCode <- map["verifyCode"]
    }
}
