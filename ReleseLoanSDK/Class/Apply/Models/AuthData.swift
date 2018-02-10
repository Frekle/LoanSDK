//
//  AuthData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/5.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class AuthData: BaseData {

    var isAuth: Bool?
    var authUrl: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        isAuth <- map["isAuth"]
        authUrl <- map["authUrl"]
    }
}
