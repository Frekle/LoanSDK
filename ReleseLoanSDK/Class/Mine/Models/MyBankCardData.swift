//
//  MyBankCardData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/9.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class MyBankCardData: BaseData {

    var openOrg = ""
    var instDate = 0
    var openCity = ""
    var updtDate = ""
    var id = ""
    var openAddr = ""
    var custNo = ""
    var instUserNo = ""
    var bankType = ""
    var openProv = ""
    var stat = ""
    var acctName = ""
    var acctNo = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        openOrg <- map["openOrg"]
        instDate <- map["instDate"]
        openCity <- map["openCity"]
        updtDate <- map["updtDate"]
        id <- map["id"]
        openAddr <- map["openAddr"]
        custNo <- map["custNo"]
        instUserNo <- map["instUserNo"]
        bankType <- map["bankType"]
        openProv <- map["openProv"]
        stat <- map["stat"]
        acctName <- map["acctName"]
        acctNo <- map["acctNo"]
        
    }
}
