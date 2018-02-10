//
//  CommonUtils.swift
//  UTOO
//
//  Created by Frekle on 2017/4/18.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation

struct CommonUtils {
    static func delay(_ delayTime: Double, callBack: @escaping () -> Void) {
        let delay = delayTime * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            callBack()
        }
//        @escaping @convention(block) () -> Swift.Void
//        DispatchQueue.main.async {
        
//        }
    }
}

//struct Timer {
//    let time = 
//}
