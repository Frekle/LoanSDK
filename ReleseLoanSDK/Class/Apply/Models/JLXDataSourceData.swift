//
//  JLXDataSourceData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/7.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class JLXDataSourceData: BaseData {
    
    var categoryName = ""
    var websiteCode = 0
    var offlineTimes = 0
    var id = ""
    var resetPwdMethod = 0
    var status = 0
    var category = ""
    var resetPwdFrozenTime = 0
    var website = ""
    var smsRequired = 0
    var requiredCaptchaUserIdentified = 0
    var name = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        categoryName <- map["category_name"]
        websiteCode <- map["website_code"]
        offlineTimes <- map["offline_times"]
        id <- map["id"]
        resetPwdMethod <- map["reset_pwd_method"]
        status <- map["status"]
        category <- map["category"]
        resetPwdFrozenTime <- map["reset_pwd_frozen_time"]
        website <- map["website"]
        smsRequired <- map["sms_required"]
        requiredCaptchaUserIdentified <- map["required_captcha_user_identified"]
        name <- map["name"]
        
    }
}
