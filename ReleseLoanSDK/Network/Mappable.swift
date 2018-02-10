////
////  MapObject.swift
////  UTOOS
////
////  Created by Frekle on 2017/8/23.
////  Copyright © 2017年 Wang. All rights reserved.
////
//
//import UIKit
//import RxSwift
//import Moya
//import ObjectMapper
//
//extension Observable {
//    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
//        return self.map { response in
//            debugLog(response)
//            guard let dic = response as? [String: Any] else {
//                throw NetworkError.parseJSONError
//            }
//            guard let obj = Mapper<T>().map(JSON: dic) else {
//                throw NetworkError.mapperJSONError
//            }
//            return obj
//        }
//    }
//}
