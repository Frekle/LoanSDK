//
//  Scale.swift
//  UTOO
//
//  Created by Frekle on 2017/2/16.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import UIKit

struct Scale {
    
    static func width(_ width: CGFloat) -> CGFloat {
        return width * Screen.width / 375.0
    }
    
    static func height(_ height: CGFloat) -> CGFloat {
        return height * Screen.height / 667.0
    }
    
    static func selectHeight(_ iPhone4: CGFloat, iPhone5: CGFloat, iPhone6: CGFloat, iPhone6Plus: CGFloat) -> CGFloat {
        switch Screen.height {
        case 480:
            return iPhone4
        case 568:
            return iPhone5
        case 667:
            return iPhone6
        case 736:
            return iPhone6Plus
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
    
}
