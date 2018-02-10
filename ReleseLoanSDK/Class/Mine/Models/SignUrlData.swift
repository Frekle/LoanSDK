//
//  SignUrlData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/9.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class SignUrlData: BaseData {

    var contractNo = ""
    var url = ""
    var status = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        contractNo <- map["contractNo"]
        url <- map["url"]
        status <- map["status"]
    }
}
