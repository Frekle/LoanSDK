//
//  SaveFaceidSimilaryData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/9.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper
class SaveFaceidSimilaryData: BaseData {

    var isSave = false
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        isSave <- map["isSaved"]
    }
}
