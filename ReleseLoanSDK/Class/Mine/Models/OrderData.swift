//
//  OrderData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/7.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class OrderData: BaseData {

    var isMainLoanNo = ""
    var applyDate = 0
    var instDate = 0
    var instNum = 0
    var stat = ""
    var buyInsuAmt = 0
    var isSel = ""
    var loanAmt = 0
    var loanNo = ""
    var mainLoanNo = ""
    var custName = ""
    var rejectRemark = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        isMainLoanNo <- map["isMainLoanNo"]
        applyDate <- map["applyDate"]
        instDate <- map["instDate"]
        instNum <- map["instNum"]
        stat <- map["stat"]
        buyInsuAmt <- map["buyInsuAmt"]
        isSel <- map["isSel"]
        loanAmt <- map["loanAmt"]
        loanNo <- map["loanNo"]
        mainLoanNo <- map["mainLoanNo"]
        custName <- map["custName"]
        rejectRemark <- map["rejectRemark"]
        
    }
}

class OrderDetailData: BaseData {
    
    var applyDate = 0
    var instNum = 0
    var mthRepayAmt = 0.0
    var buyInsuAmt = 0
    var isSel = ""
    var loanAmt = 0
    var mainLoanNo = ""
    var custName = ""
    var rejectRemark = ""
    var isCredit = ""
    var isMainLoanNo = ""
    var isVip = ""
    var stat = ""
    var loanNo = ""
    var prodNo = ""
    var mthRepayDate = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        applyDate <- map["applyDate"]
        instNum <- map["instNum"]
        mthRepayAmt <- map["mthRepayAmt"]
        buyInsuAmt <- map["buyInsuAmt"]
        isSel <- map["isSel"]
        loanAmt <- map["loanAmt"]
        mainLoanNo <- map["mainLoanNo"]
        custName <- map["custName"]
        rejectRemark <- map["rejectRemark"]
        isCredit <- map["isCredit"]
        isMainLoanNo <- map["isMainLoanNo"]
        isVip <- map["isVip"]
        stat <- map["stat"]
        loanNo <- map["loanNo"]
        prodNo <- map["prodNo"]
        mthRepayDate <- map["mthRepayDate"]
        
    }
}
