//
//  FaceIdApi.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/24.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation
import Alamofire

enum FaceIdApi {
    case getFaceIdToken
    case doVertification(token: String)
    case getResult(bizId: String)
//    case bankcard(image: )
}

extension FaceIdApi: FKTargetType {
    /// The HTTP method used in the request.
    var method: HTTPMethod {
        switch self {
        case .getFaceIdToken:
            return .post
        default:
            return .get
        }
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: Constants.serverURL)!
    }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any] {
        switch self {
        case .getFaceIdToken:
            return ["api_key": Constants.faceIdAppKey,
                    "api_secret": Constants.faceIdAppSecret,
                    "return_url": Constants.faceIdReturnUrl, // 用户完成或取消验证后网页跳转的目标URL。
                "notify_url": Constants.faceIdNotifyUrl, // 用户完成验证、取消验证、或验证超时后，由FaceID服务器请求客户服务器的URL。
                "biz_no": UserInfo.shared().user?.loginNo ?? "", // 客户业务流水号
                //                    "biz_extra_data": "",
//                "web_title": "",
                //                    "scene_id": "",
                "comparison_type": "1",
                "idcard_mode": "2"]
//                "idcard_name": "王振宇",
//                "idcard_number": "510623199301268617"]
        case .doVertification(token: let token):
            return ["token": token]
        case .getResult(bizId: let bizId):
            return ["api_key": Constants.faceIdAppKey,
                    "api_secret": Constants.faceIdAppSecret,
                    "biz_id": bizId,
                    "return_image": "4"]
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getFaceIdToken:
            return "https://api.megvii.com/faceid/lite/get_token"
        case .doVertification:
            return "https://api.megvii.com/faceid/lite/do"
        case .getResult:
            return "https://api.megvii.com/faceid/lite/get_result"
        }
    }
}

