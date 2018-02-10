//
//  NetWorkManager.swift
//  UTOO
//
//  Created by Wang on 16/8/3.
//  Copyright © 2016年 Wang. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
//import Moya
//import RxSwift

public struct NetWorkManager {
    
    internal typealias RequestableCompletion = (HTTPURLResponse?, URLRequest?, Data?, Swift.Error?) -> Void
    
    public static var httpHeader: [String: String] {
        get {
            var dic = [String: String]()
            dic["Content-Type"] = "application/json"
            switch api {
            case .login, .regist, .findPassword:
                break
            default:
                dic["Authorization"] = UserInfo.shared().user?.Authorization
            }
            return dic
        }
    }
    
    private static let failureResultDic: [String : Any] = ["code": -1,
                                 "error": "网络暂时不通畅，请稍后再试"]
    static var api = Api.authOnlineBank
    
    static func request<T: Mappable>(api: Api,
                       successHandler: @escaping (T) -> Void,
                       failureHandler: @escaping (BaseData) -> Void) {
        
        debugLog(api.fullPath + api.parameters.parsingParams())
        
        NetWorkManager.api = api
        var header = NetWorkManager.httpHeader
        var encoding: ParameterEncoding!
        switch api {
        case .checkIsNeedCollect,
             .datasourceOfJLX:
//        , .submitJLXRequest:
            header = [:]
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.default
        }
        
        Alamofire.request(api.fullPath, method: api.method, parameters: api.parameters, encoding: encoding, headers: header).responseObject { (resp: DataResponse<T>) in
            
            Window?.hidAllHud()
            
            
            switch api {
            case .login:
                if let header = resp.response?.allHeaderFields {
                    if let token = header["Authorization"] as? String {
                        
                        if let user = UserInfo.shared().user {
                            user.Authorization = token
                            UserInfo.shared().setLoginedUserCached(user)
                            debugLog(UserInfo.shared().getLoginUserCached()?.Authorization)
                        }
                    }
                }
            default:
                break
            }
            
            
            guard let resultData = resp.data else{ return }
            let resultJson = String(data: resultData, encoding: String.Encoding.utf8) ?? ""
            debugLog(resultJson)
            
            let result = resp.result
            if result.isSuccess {
                guard let resultValue = result.value else{ return }
                switch api {
                case .checkIsNeedCollect:
                    successHandler(resultValue)
                default:
                    if let data = Mapper<BaseModel<BaseData>>().map(JSONString: resultJson) {
                        if data.success {
                            successHandler(resultValue)
                        } else {
                            Window?.hidAllHud()
                            Window?.showHUD(data.msg)
                            failureHandler(data)
                        }
                    }
                }
            } else {
                debugLog(result.error)
                if let failureValue = Mapper<BaseData>().map(JSON: NetWorkManager.failureResultDic) {
                    Window?.showHUD(failureValue.msg)
                    failureHandler(failureValue)
                }
            }
        }
    }
    
    static func uploadImage(attType: String, oldAtt: String, image: UIImage, callback:@escaping (AttachmentData) -> Void) {
        Window?.showLoading()
        let url = Constants.serverURL + "/bycx-rece-service/tempSysAtt/load/upload"
        let busNo = UserInfo.shared().loanNo
        let busiType = "21400001"
        let attType = attType
        let queryType = "TEMP"
        let oldAtt = oldAtt

        let imageData = UIImageJPEGRepresentation(image, 0.1)
        
        //业务： 21400001   银行卡正面：20800002  银行卡反面：20800003
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            guard let busNoData = busNo.data(using: .utf8) else { return }
            guard let busiTypeData = busiType.data(using: .utf8) else { return }
            guard let attTypeData = attType.data(using: .utf8) else { return }
            guard let queryTypeData = queryType.data(using: .utf8) else { return }
            guard let oldAttData = oldAtt.data(using: .utf8) else { return }
            guard let imageData = imageData else { return }
            
            multipartFormData.append(busNoData, withName: "busiNo")
            multipartFormData.append(busiTypeData, withName: "busiType")
            multipartFormData.append(attTypeData, withName: "attTyp")
            multipartFormData.append(queryTypeData, withName: "queryType")
            multipartFormData.append(oldAttData, withName: "oldAtt")
//            multipartFormData.append(imageData, withName: "file")
            multipartFormData.append(imageData, withName: "file", fileName: "", mimeType: "iamge/jpg")
            debugLog(multipartFormData)
        }, usingThreshold: UInt64(), to: url, method: .post, headers: NetWorkManager.httpHeader) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (resp: DataResponse<AttachmentData>) in
                    guard let resultData = resp.data else{ return }
                    let resultJson = String(data: resultData, encoding: String.Encoding.utf8) ?? ""
                    debugLog(resultJson)
                    guard let resultValue = resp.value else{return}
                    callback(resultValue)
                    Window?.hidAllHud()
                })
            case .failure(let encodingError):
                Window?.hidAllHud()
                break
            }
        }
    }
 
    static func parsingParams(param: [String: Any]) -> String {
        var paramString = "?"
        var index = 0
        param.forEach { (key, value) in
            index += 1
            paramString.append("\(key)=\(value)")
            if index < param.count {
                paramString.append("&")
            }
        }
        return paramString
    }
}

public struct FaceIdNetwork {
    
    internal typealias RequestableCompletion = (HTTPURLResponse?, URLRequest?, Data?, Swift.Error?) -> Void
    
    public static var httpHeader: [String: String] {
        get {
            let dic = [String: String]()
            return dic
        }
    }
    
    private static let failureResultDic: [String : Any] = ["code": -1,
                                                           "error": "网络暂时不通畅，请稍后再试"]
    
    static func request<T: Mappable>(api: FaceIdApi,
                                     successHandler: @escaping (T) -> Void,
                                     webSucccessHandler: ((String) -> Void)? = nil,
                                     failureHandler: @escaping (BaseData) -> Void) {
        
        let param = api.parameters
        debugLog(api.path + param.parsingParams())
        
        Alamofire.request(api.path, method: api.method, parameters: param, encoding: URLEncoding.default, headers: FaceIdNetwork.httpHeader).responseObject { (resp: DataResponse<T>) in
            
            Window?.hidAllHud()
            
            guard let resultData = resp.data else{ return }
            let resultJson = String(data: resultData, encoding: String.Encoding.utf8) ?? ""
            debugLog(resultJson)
            
            switch api {
            case .doVertification:
                webSucccessHandler?(resultJson)
            default:
                let result = resp.result
                if result.isSuccess {
                    guard let resultValue = result.value else{ return }
                    successHandler(resultValue)
                } else {
                    debugLog(result.error)
                    if let failureValue = Mapper<BaseData>().map(JSON: FaceIdNetwork.failureResultDic) {
                        Window?.showHUD(failureValue.msg)
                        failureHandler(failureValue)
                    }
                }
            }
        }
    }
    
    static func uploadImageToFaceId(image: UIImage, callback:@escaping (FaceIdBankData) -> Void) {
        Window?.showLoading()
        let url = "https://api.megvii.com/faceid/v3/ocrbankcard"
        let apiKey = Constants.faceIdAppKey
        let secret = Constants.faceIdAppSecret
//        let file = Bundle.main.path(forResource: image, ofType: "JPG")
//        let imageData = UIImagePNGRepresentation(UIImage(contentsOfFile: file!)!)
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            guard let apiKeyData = apiKey.data(using: .utf8) else { return }
            guard let secretData = secret.data(using: .utf8) else { return }
            guard let imageData = imageData else { return }
            multipartFormData.append(apiKeyData, withName: "api_key")
            multipartFormData.append(secretData, withName: "api_secret")
            multipartFormData.append(imageData, withName: "image", fileName: "image", mimeType: "iamge/jpg")
            debugLog(multipartFormData)
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (resp: DataResponse<FaceIdBankData>) in
                    Window?.hidAllHud()
                    guard let resultData = resp.data else{ return }
                    let resultJson = String(data: resultData, encoding: String.Encoding.utf8) ?? ""
                    debugLog(resultJson)
                    guard let resultValue = resp.value else{return}
                    callback(resultValue)
                })
            case .failure(let encodingError):
                Window?.hidAllHud()
                break
            }
        }
    }
    
//    static func parsingParams(param: [String: Any]) -> String {
//        var paramString = "?"
//        var index = 0
//        param.forEach { (key, value) in
//            index += 1
//            paramString.append("\(key)=\(value)")
//            if index < param.count {
//                paramString.append("&")
//            }
//        }
//        return paramString
//    }
}

class FaceIdBankData: BaseData {
    var requestId = ""
    var result = 0
    var timeUsed = 0
    var name = ""
    var number = ""
    var bank = ""
    var organization = ""
    var validDate = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        requestId <- map["request_id"]
        result <- map["result"]
        timeUsed <- map["time_used"]
        name <- map["name"]
        number <- map["number"]
        bank <- map["bank"]
        organization <- map["organization"]
        validDate <- map["valid_date"]
    }
}

