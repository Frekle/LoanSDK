//
//  ProdListData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/4.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class ProdListData: BaseData {
        
    var setlPrior = ""
    var feeNo = ""
    var feeName = ""
    var instDate = ""
    var instNum = ""
    var updtDate = ""
    var isSel = ""
    var id = ""
    var feeVal = ""
    var prodNo = ""
    var instUserNo = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        setlPrior <- map["setlPrior"]
        feeNo <- map["feeNo"]
        feeName <- map["feeName"]
        instDate <- map["instDate"]
        instNum <- map["instNum"]
        updtDate <- map["updtDate"]
        isSel <- map["isSel"]
        id <- map["id"]
        feeVal <- map["feeVal"]
        prodNo <- map["prodNo"]
        instUserNo <- map["instUserNo"]
        
    }
}
