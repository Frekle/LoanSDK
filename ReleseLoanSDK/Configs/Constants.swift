//
//  Constants.swift
//  UTOO
//
//  Created by Frekle on 2017/2/20.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation

struct Constants {
    fileprivate enum AppConfigType {
        case debug
        case relese
    }

    fileprivate static var currentConfig: AppConfigType {
        #if DEBUG
            return .debug
        #else
            return .relese
        #endif
    }
    
    static var serverURL: String {
//        return "http://121.199.9.85:8010"
        return "http://47.96.37.141:8730"
    }
    
    static var ecommerceUrl: String {
        switch currentConfig {
        case .debug:
            return "http://121.199.9.85:8010"
//            return "http://api.9ffenqigo.com"
        default:
            return "http://api.9ffenqigo.com"
        }
    }
    
    static var authOnlineBankUrl: String {
        return "https://api.51datakey.com"
    }
    
    static var serverJLXUrl: String {
        return "https://www.juxinli.com"
    }
    
    
    
    static var isDebug: Bool {
        switch currentConfig {
        case .debug:
            return true
        default:
            return false
        }
    }
    
    /* 友盟 */
    static let umAppKey = "584677593eae25075e000965"
    
    /* 微信 */
    static let wechatAppKey = "wx0859438800a3f7fe"
    static let wechatSecret = "db426a9829e4b49a0dcac7b4162da6b6"
    
    /* QQ */
    static let qqAppKey = "1105025352"
    
    /* 激光推送 */
    static let jpushAppkey = "45569763caba548067142207"
    static let jpushChannel = "Publish channel"
    
    /* faceId */
    static let faceIdAppKey = "eJHXmuD-n4Gfh9sb6RTWS9r3vhfKLI4g"
    static let faceIdAppSecret = "-CMssxddZpY9bWUtSE_Tp4xtlhBkgWN4"
    static let faceIdReturnUrl = "http://www.baidu.com"
    static let faceIdNotifyUrl = "http://www.jianshu.com"
    
    static let prodNumber = "60203"
    static let source_type = "26600001"
    static let source_os_type = "30500017"
    
    static let authtype_bank = "36100001"
    static let authtype_zhima = "36100002"
    static let authtype_ecnomic = "36100003"
    static let authtype_catch = "36100004" // 信用卡或储蓄卡抓取认证
    static let authtype_mobile = "36100005"
    
    static let authtype_online_apikey = "6c5e1df0d026494695f75c41ae539b39"
    static let authtype_online_backurl = "authtypeOnlineBackurl"
}
