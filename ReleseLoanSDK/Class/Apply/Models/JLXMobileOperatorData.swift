//
//  JLXMobileOperatorData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/7.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class JLXMobileOperatorData: BaseData {

    var token = ""
    var mobile = ""
    var datasource: JLXDataSourceData!
    override func mapping(map: Map) {
        super.mapping(map: map)
        token <- map["token"]
        mobile <- map["cell_phone_num"]
        datasource <- map["datasource"]
    }
}
