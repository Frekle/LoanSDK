//
//  InstListData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/4.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class InstListData: BaseData {
    var instList: [String]?
    override func mapping(map: Map) {
        super.mapping(map: map)
        instList <- map["result"]
    }
}
