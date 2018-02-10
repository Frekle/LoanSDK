//
//  OpenClass.swift
//  UTOOS
//
//  Created by Frekle on 2017/7/25.
//  Copyright © 2017年 Wang. All rights reserved.
//

import Foundation
import UIKit

func debugLog<T>(_ message : T){
    if Constants.isDebug {
        print(message)
        print("\n")
    }
}

let Window = UIApplication.shared.windows.first

func isNull(_ key:Any?) -> String {
    
    var str = "";
    if key == nil {
        str = "";
    }else if (key! as AnyObject).isKind(of: NSNull.self) {
        str = "";
    }else {
        str = "\(key!)"
    }
    return str;
}


