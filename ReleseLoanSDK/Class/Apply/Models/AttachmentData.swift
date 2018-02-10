//
//  AttachmentData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/6.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class AttachmentData: BaseData {
    
    var oldAtt = ""
    var instDate = 0
    var busiNo = ""
    var updtUserOrg = ""
    var attTyp = ""
    var attSize = ""
    var remark = ""
    var inPath = ""
    var updtDate = 0
    var id = ""
    var instUserOrg = ""
    var newAtt = ""
    var alyFileServerAddr = ""
    var instUserNo = ""
    var updtUserName = ""
    var instUserName = ""
    var updtUserNo = ""
    var busiTyp = ""
    var isInAtt = ""
    var attFile = ""
    var sort = ""
    var phPath = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        oldAtt <- map["oldAtt"]
        instDate <- map["instDate"]
        busiNo <- map["busiNo"]
        updtUserOrg <- map["updtUserOrg"]
        attTyp <- map["attTyp"]
        attSize <- map["attSize"]
        remark <- map["remark"]
        inPath <- map["inPath"]
        updtDate <- map["updtDate"]
        id <- map["id"]
        instUserOrg <- map["instUserOrg"]
        newAtt <- map["newAtt"]
        alyFileServerAddr <- map["alyFileServerAddr"]
        instUserNo <- map["instUserNo"]
        updtUserName <- map["updtUserName"]
        instUserName <- map["instUserName"]
        updtUserNo <- map["updtUserNo"]
        busiTyp <- map["busiTyp"]
        isInAtt <- map["isInAtt"]
        attFile <- map["attFile"]
        sort <- map["sort"]
        phPath <- map["phPath"]
        
    }
}
