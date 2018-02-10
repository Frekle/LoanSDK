//
//  NetworkError.swift
//  UTOOS
//
//  Created by Frekle on 2017/8/23.
//  Copyright © 2017年 Wang. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case parseJSONError
    case mapperJSONError
    case notLogin
    case other
}
