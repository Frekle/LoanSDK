//
//  ProdData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/5.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class ProdData: BaseData {

    var mthAmt: Double = 0
    var busiDate = ""
    var instNum = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        mthAmt <- map["mthAmt"]
        busiDate <- map["busiDate"]
        instNum <- map["instNum"]
    }
}

class LoanNumberData: BaseData {
    var loanNo = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        loanNo <- map["loanNo"]
    }
}
