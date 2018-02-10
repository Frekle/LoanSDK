//
//  UserManager.swift
//  UTOOS
//
//  Created by Frekle on 2017/8/8.
//  Copyright © 2017年 Wang. All rights reserved.
//

import UIKit

struct CachedData {

    static let registKey = "registKey"

    static func saveLocalData(_ key: String, value:Any?) {
        let data:UserDefaults = UserDefaults.standard
        data.set(value, forKey: key)
    }
    
    static func getLocalData(_ key: String) -> Any? {
        let data:UserDefaults = UserDefaults.standard
        return data.object(forKey: key)
    }
    
    static func removeLocalData(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
}


