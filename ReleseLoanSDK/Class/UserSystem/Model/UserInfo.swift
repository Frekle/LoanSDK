//
//  UserInfo.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/23.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class UserDataModel: BaseData {
//    var loginType = ""
    var password = ""
    var loginNo = ""
//    var imei = ""
//    var applyType = ""
//    var sourceOsType = ""
    var Authorization = ""
    var userName = ""
    var idCardNumber = ""
    var certificationed = false
    
    override func mapping(map: Map) {
        super.mapping(map: map)
//        loginType <- map["loginType"]
        password <- map["password"]
        loginNo <- map["loginNo"]
//        imei <- map["imei"]
//        applyType <- map["applyType"]
//        sourceOsType <- map["sourceOsType"]
        Authorization <- map["Authorization"]
        userName <- map["userName"]
        idCardNumber <- map["idCardNumber"]
        certificationed <- map["certificationed"]
    }
    
    static func shareUser(dic: Dictionary<String, String>) -> UserDataModel {
        let user = UserDataModel()
//        user.loginType = dic["loginType"] ?? ""
        user.password = dic["password"] ?? ""
        user.loginNo = dic["loginNo"] ?? ""
//        user.applyType = dic["applyType"] ?? ""
//        user.imei = dic["imei"] ?? ""
//        user.sourceOsType = dic["sourceOsType"] ?? ""
        user.Authorization = dic["Authorization"] ?? ""
        user.userName = dic["userName"] ?? ""
        user.idCardNumber = dic["idCardNumber"] ?? ""
        return user
    }
}

class UserInfo: NSObject {
    
    lazy var user: UserDataModel? = {
        return self.getLoginUserCached()
    }()
    
    var loanNo = ""
    
    fileprivate let key_logined_user_cache = "key_logined_user_cache"
    
    fileprivate static let userInfo = UserInfo()
    
    static func shared() -> UserInfo {
        return userInfo
    }
    
    fileprivate override init() {
        super.init()
    }
    
    //缓存登录数据
    func setLoginedUserCached(_ userData:UserDataModel?) {
        if let data = userData {
            user = data
            let jsonString = Mapper().toJSONString(data, prettyPrint: true)
            CachedData.saveLocalData(key_logined_user_cache, value: jsonString)
        }
    }
    
    //获取缓存的登录数据
    func getLoginUserCached() -> UserDataModel? {
        if let jsonString = CachedData.getLocalData(key_logined_user_cache) as? String {
            return Mapper<UserDataModel>().map(JSONString: jsonString)
        }
        return nil
    }
    
    // 清除缓存的登录数据
    func cleanLoginUserCached() {
        CachedData.removeLocalData(key_logined_user_cache)
        self.user = nil
    }
    
    func logout() {
        UserInfo.shared().cleanLoginUserCached()
    }
}
