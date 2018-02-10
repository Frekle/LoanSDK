//
//  JLXCollectRespData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/7.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class JLXCollectRespData: BaseData {

    var type = ""
    var content = ""
    var processCode = 0
    var finish = false
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        type <- map["type"]
        content <- map["content"]
        processCode <- map["process_code"]
        finish <- map["finish"]
    }
}
