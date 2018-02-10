//
//  BaseData.swift
//  UTOO
//
//  Created by Frekle on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import UIKit
import ObjectMapper

//13330940566

class BaseData: NSObject, Mappable {

    var pages = 0
    var order = ""
    var list = ""
    var code = ""
    var success = false
    var flat = ""
    var t = ""
    var isPage = 0
    var totalSize = ""
    var orderDesc = ""
    var pageNo = 0
    var pageSize = 0
    var msg = ""
    var resultString = ""
    var resultBool = false
    
    var tempCode = 0
    var tempData: TempBaseData?
    
    override init(){
        super.init()
    }
    
    required init(map: Map) {
        super.init()
        pages <- map["pages"]
        order <- map["order"]
        list <- map["list"]
        code <- map["code"]
        success <- map["success"]
        flat <- map["result.flat"]
        t <- map["t"]
        isPage <- map["isPage"]
        totalSize <- map["totalSize"]
        orderDesc <- map["orderDesc"]
        pageNo <- map["pageNo"]
        pageSize <- map["pageSize"]
        msg <- map["msg"]
        if msg == "" {
            msg <- map["message"]
        }
        resultString <- map["result"]
        resultBool <- map["result"]
        tempCode <- map["code"]
        tempData <- map["data"]
    }
    
    func mapping(map: Map) {
        
    }
    
}

class BaseModel<T: Mappable>: BaseData {
    var data: T?
    var datas: [T]?
    var jlxDatas: [T]?
    var jlxData: T?
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["result"]
        datas <- map["result"]
        jlxDatas <- map["data"]
        jlxData <- map["data"]
    }

}

class TempBaseData: BaseData {
    var result = false
    override func mapping(map: Map) {
        super.mapping(map: map)
        result <- map["result"]
        result <- map["data"]
    }
}

