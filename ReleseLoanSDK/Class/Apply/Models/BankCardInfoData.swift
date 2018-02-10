//
//  BankCardInfoData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/10.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class BankCardInfoData: BaseData {

    var bankInfo: BankInfoData?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        bankInfo <- map["bankInfo"]
    }
}

class BankInfoData: BaseData {
    var is_matched = true
    var province = ""
    var city = ""
    var bank_name = ""
    var card_type = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        is_matched <- map["is_matched"]
        province <- map["province"]
        city <- map["city"]
        bank_name <- map["bank_name"]
        card_type <- map["card_type"]
    }
}
