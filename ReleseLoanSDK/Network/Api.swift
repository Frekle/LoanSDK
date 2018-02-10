//
//  Api.swift
//  UTOO
//
//  Created by Frekle on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import Alamofire
//import Moya

public protocol FKTargetType {
    /// The target's base `URL`.
//    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any] { get }
    
    /// The HTTP method used in the request.
    var method: Alamofire.HTTPMethod { get }
}

enum CaptchaType: String {
    case submit = "SUBMIT_CAPTCHA" // 提交短信验证码
    case resend = "RESEND_CAPTCHA" // 重发短信验证码
    case submitQuery = "SUBMIT_QUERY_PWD" // 提交查询密码
}

enum Api {
    case regist(username: String,password: String,verifyword:String)
    case login(phone: String, passwd: String, loginType: String, applyType: String, sourceOsType: String, imei: String)
    case findPassword(phone: String, passwd: String, verifyCode: String)
    case isRegist(phone: String)
    case changePassword(phone: String, passwd: String, oldPassword: String)
    case validateSms(phone: String, verifyCode: String)
    case sendSms(phone: String)
    case getCodeImg()
    case saveBankCardInfo(phone: String, acctNo: String, acctName: String, openOrg: String, openProv: String, openCity: String, openAddr: String, bankType: String)
    case clockList(list: [String])
    /* 申请人资质 */
    case preGenarateLoanNo(prodNo: String)
    case step1Save(phone: String, custName: String, sex: String, workJob: String, ethnic: String, marriage: String, certNo: String, certOrg: String, certValidDate: String, regProv: String, regCity: String, regArea: String, regAddr: String, liveProv: String, liveCity: String, liveArea: String, liveAddr: String, qq: String, edu: String)
    case checkAuth(authItem: String)
    case getAuth(authItem: String)
    // 保存联系人信息
    case saveContact(list: [ContactData])
    case checkContact(phone: String)
    // 保存公司信息
    case saveWork(unitName: String, unitTel: String, industry: String, workPost: String, workJob: String, unitProv: String, unitCity: String, unitArea: String, unitAddr: String)
    case checkWork(phone: String)
    
    // 手机运营商认证
    case checkIsNeedCollect(userId: String, account: String, website: String)
    case passTheData(token: String, phone: String)
    // 聚立信
    case datasourceOfJLX
    case submitTheJLXForm(phone: String) // 提交表单获取回执信息
    case submitJLXRequest(token: String, account: String, password: String, captcha: String, type: CaptchaType, website: String)
    case getJLXCollectResp(token: String, account: String, password: String, captcha: String, type: CaptchaType, website: String)
    
    
    // 人脸识别相似度保存接口
    case saveFace(idCard: String, name: String, score: String)
    
    // 产品期数
    case instNum(prodNo: String)
    // 产品试算
    case prodCalc(prodNo: String, instNum: String, goodsAmt: String, payAmt: String, feeNos: String)
    // 产品试算保存
    case saveProdTrial(custName: String, instNum: String, loanAmt: String, mthRepayAmt: String, fstRepayDate: String, feeList: [String])
    // 客户可选的产品费用项查询接口
    case custProdFee(instNum: String)
    // 获取芝麻分认证URL接口
    case getZhimaAuthUrl
    // 订单接口
    case orderList(status: String?)
    // 订单详情
    case orderDetails(loanNo: String)
    // 我的银行卡
    case myBankCard
    // 网银认证h5
    case authOnlineBank
    // 提交申请
    case submitApply
    // 取消贷款
    case cancelLoanApply(loanNo: String)
    // 获取签约地址
    case getSignUrl(loanNo: String)
    //  银行卡四要素校验接口
    case verifyBankCard(bankCard: String, name: String)
}

extension Api: FKTargetType {
    /// The HTTP method used in the request.
    var method: HTTPMethod {
        switch self {
        case .checkIsNeedCollect, .datasourceOfJLX, .authOnlineBank:
            return .get
        default:
            return .post
        }
    }

    /// The parameters to be encoded in the request.
    var parameters: [String: Any] {
        
        var tempParam = [String: Any]()
        
        switch self {
            
        case .regist(username:let username,password: let password, verifyword:let verifyword):
            tempParam = ["loginType": "24200004",
                    "registSource": "39300014",
                    "loginNo": username,
                    "password": password,
                    "verifyCode": verifyword]
        case .sendSms(phone: let phone):
            tempParam = ["phone": phone,
                    "sourceOsType": "30500017"]
        case .login(phone: let phone, passwd: let password, loginType: let loginType, applyType: let applyType, sourceOsType: let sourceOsType, imei: let imei):
            tempParam = ["loginNo": phone,
                         "password": password,
                         "loginType": loginType,
                         "applyType": applyType,
                         "imei": imei,
                         "sourceOsType": sourceOsType]
            if let user = UserInfo.shared().user {
                user.loginNo = phone
                user.password = password
//                let user = UserDataModel.shareUser(dic: tempParam as! Dictionary<String, String>)
                UserInfo.shared().setLoginedUserCached(user)
            }
            
        case .findPassword(phone: let phone, passwd: let password, verifyCode: let verifyCode):
            tempParam = ["loginNo": phone,
                    "password": password,
                    "verifyCode": verifyCode]
        case .changePassword(phone: let phone, passwd: let password, oldPassword: let oldPassword):
            tempParam = ["loginNo": phone,
                    "password": password,
                    "oldpassword": oldPassword]
        case .isRegist(phone: let phone):
            tempParam = ["loginNo": phone]
        case .validateSms(phone: let phone, verifyCode: let code):
            tempParam = ["phone": phone,
                    "verifyCode": code]
        case .saveBankCardInfo(phone: let phone, acctNo: let acctNo, acctName: let acctName, openOrg: let openOrg, openProv: let openProv, openCity: let openCity, openAddr: let openAddr, bankType: let bankType):
            tempParam = ["phoneNo": phone,
                    "acctNo": acctNo,
                    "acctName": acctName,
                    "openOrg": openOrg,
                    "openProv": openProv,
                    "openCity": openCity,
                    "openAddr": openAddr,
                    "bankType": bankType]
            
        case .clockList(list: let list):
            
            var arr = [[String: String]]()
            list.forEach({ (type) in
                var dic = [String: String]()
                dic["type"] = type
                arr.append(dic)
            })
            tempParam = ["list": arr]
            
        case .preGenarateLoanNo(prodNo: let no):
            tempParam = ["prodNo": no]
            
        case .step1Save(phone: let phone, custName: let custName, sex: let sex, workJob: let workJob, ethnic: let ethnic, marriage: let marriage, certNo: let certNo, certOrg: let certOrg, certValidDate: let certValidDate, regProv: let regProv, regCity: let regCity, regArea: let regArea, regAddr: let regAddr, liveProv: let liveProv, liveCity: let liveCity, liveArea: let liveArea, liveAddr: let liveAddr, qq: let qq, edu: let edu):
            tempParam = ["phoneNo": phone, "custName": custName, "sex": sex, "workJob": workJob,
                    "ethnic": ethnic, "marriage": marriage, "certNo": certNo, "certOrg": certOrg,
                    "certValidDate": certValidDate, "regProv": regProv, "regCity": regCity,
                    "regArea": regArea, "regAddr": regAddr, "liveProv": liveProv, "liveCity": liveCity,
                    "liveArea": liveArea, "liveAddr": liveAddr, "qq": qq, "edu": edu]
        case .checkAuth(authItem: let authItem):
            tempParam = ["user_id": UserInfo.shared().loanNo,
                    "name": UserInfo.shared().user?.userName ?? "",
                    "phone_num": UserInfo.shared().user?.loginNo ?? "",
                    "id_card_num": UserInfo.shared().user?.idCardNumber ?? "",
                    "auth_item": authItem]
        case .getAuth(authItem: let authItem):
            tempParam = ["user_id": UserInfo.shared().loanNo,
                    "name": UserInfo.shared().user?.userName ?? "",
                    "phone_num": UserInfo.shared().user?.loginNo ?? "",
                    "id_card_num": UserInfo.shared().user?.idCardNumber ?? "",
                    "auth_item": authItem]
        case .saveContact(list: let list):
            var dicList = [[String: String]]()
            list.forEach({ (contact) in
                let dic = contact.todic()
                dicList.append(dic)
            })
            tempParam = ["list": dicList]
        case .checkContact(phone: let phone):
            tempParam = ["phoneNo": phone]
        case .saveWork(unitName: let unitName, unitTel: let unitTel, industry: let industry, workPost: let workPost, workJob: let workJob, unitProv: let unitProv, unitCity: let unitCity, unitArea: let unitArea, unitAddr: let unitAddr):
            tempParam = ["phoneNo": UserInfo.shared().user?.loginNo ?? "",
                    "workUnit": unitName,
                    "unitTel": unitTel,
                    "industry": industry,
                    "workPost": workPost,
                    "workJob": workJob,
                    "unitProv": unitProv,
                    "unitCity": unitCity,
                    "unitArea": unitArea,
                    "unitAddr": unitAddr]
            
        case .checkIsNeedCollect(userId: let userId, account: let account, website: let website):
            tempParam = ["user_id": userId, "account": account, "website": website]
        case .passTheData(token: let token, phone: let phone):
            tempParam = ["user_id": UserInfo.shared().loanNo,
                    "website": "mobile",
                    "token": token,
                    "account": UserInfo.shared().user?.loginNo ?? "",
                    "id_card_nu": UserInfo.shared().user?.idCardNumber ?? "",
                    "name": UserInfo.shared().user?.userName ?? "",
                    "phone_num": phone]
        case .submitTheJLXForm(phone: let phone):
            tempParam = ["selected_website":[],
                         "basic_info": ["name": UserInfo.shared().user?.userName ?? "",
                                        "id_card_num": UserInfo.shared().user?.idCardNumber ?? "",
                                        "cell_phone_num": phone],
                         "skip_mobile": false,
                         "uid": ""]
        case .submitJLXRequest(token: let token, account: let account, password: let  password, captcha: let captcha, type: let type, website: let website):
            tempParam = ["token": token,
                         "account": account,
                         "password": password,
                         "captcha": captcha,
                         "type": type.rawValue,
                         "website": website]
        case .getJLXCollectResp(token: let token, account: let account, password: let  password, captcha: let captcha, type: let type, website: let website):
            tempParam = ["token": token,
                         "account": account,
                         "password": password,
                         "captcha": captcha,
                         "type": type.rawValue,
                         "website": website]
        case .instNum(prodNo: let prodNo):
            tempParam = ["prodNo": prodNo]
        case .prodCalc(prodNo: let prodNo, instNum: let instNum, goodsAmt: let goodsNum, payAmt: let payAmt, feeNos: let feeNos):
            tempParam = ["prodNo": prodNo,
                         "instNum": instNum,
                         "goodsAmt": goodsNum,
                         "payAmt": payAmt,
                         "feeNos": feeNos]
        case .saveProdTrial(custName: let custName, instNum: let instNum, loanAmt: let loanAmt, mthRepayAmt: let mthRepay, fstRepayDate: let fstRepay, feeList: let feeNos):
            tempParam = ["custName":custName,
                    "fileNo":"97411",
                    "sourceType": Constants.source_type,
                    "sourceUserType":"30400002",
                    "sourceOsType": Constants.source_os_type,
                    "loanAmt":loanAmt,
                    "mthRepayAmt":mthRepay,
                    "fstRepayDate":fstRepay,
                    "prodNo": Constants.prodNumber,
                    "instNum": instNum,
                    "feeNos":feeNos]
        case .custProdFee(instNum: let instNum):
            tempParam = ["prodNo": Constants.prodNumber, "instNum": instNum]
        case .getZhimaAuthUrl:
            tempParam = ["user_id": UserInfo.shared().loanNo,
                         "name": UserInfo.shared().user?.userName ?? "",
                         "id_card": UserInfo.shared().user?.idCardNumber ?? ""]
        case .orderList(status: let status):
            if let status = status {
                tempParam = ["stat": status,
                             "phoneNo": UserInfo.shared().user?.loginNo ?? ""]
            } else {
                tempParam = ["phoneNo": UserInfo.shared().user?.loginNo ?? ""]
            }
            
        case .orderDetails(loanNo: let loanNo):
            tempParam = ["loanNo": loanNo]
        case .saveFace(idCard: let idCard, name: let name, score: let score):
            tempParam = ["user_id": UserInfo.shared().loanNo,
                         "data_list": [["key": "face_score",
                                        "data": ["id_card": idCard,
                                                 "phone_num": UserInfo.shared().user?.loginNo ?? "",
                                                 "name": name,
                                                 "score": score]],
                                       ["key": "device_info",
                                        "data": ["brand": "iphone",
                                                 "model": "",
                                                 "sys_version": ""]]]]
        case .myBankCard:
            tempParam = ["phoneNo": UserInfo.shared().user?.loginNo ?? ""]
        case .authOnlineBank:
            tempParam = ["apiKey": Constants.authtype_online_apikey,
                         "userId": UserInfo.shared().loanNo,
                         "backUrl": Constants.authOnlineBankUrl]
        case .submitApply:
            tempParam = ["loanNo": UserInfo.shared().loanNo,
                         "phoneNo": UserInfo.shared().user?.loginNo ?? "",
                         "remark": ""]
        case .cancelLoanApply(loanNo: let loanNo):
            tempParam = ["loanNo": loanNo]
        case .getSignUrl(loanNo: let loanNo):
            tempParam = ["loanNo": loanNo]
        case .verifyBankCard(bankCard: let bankCard, name: let name):
            tempParam = ["name": name,
                         "id_card_num":  UserInfo.shared().user?.idCardNumber ?? "",
                         "bank_card_num": bankCard]
        default:
            tempParam = [:]
        }
        
        switch self {
        case .checkIsNeedCollect, .passTheData, .submitTheJLXForm, .datasourceOfJLX, .submitJLXRequest, .getJLXCollectResp, .authOnlineBank:
            return tempParam
        default:
            return ["params": tempParam]
        }
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .regist:
            return "/bycx-rece-service/aSysLogin/cust/regist"
        case .sendSms:
            return "/bycx-rece-service/aSysMsgCaptcha/sendSms"
        case .login:
            return "/bycx-rece-service/aSysLogin/cust/login"
        case .findPassword:
            return "/bycx-rece-service/aSysLogin/cust/fpwd"
        case .isRegist:
            return "/bycx-rece-service/aSysLogin/cust/isRegist"
        case .changePassword:
            return "/bycx-rece-service/aSysLogin/cust/mpwd"
        case .validateSms:
            return "/bycx-rece-service/aSysMsgCaptcha/validatePhoneVerifyCode"
        case .getCodeImg():
            return "/bycx-rece-service/aSysMsgCaptcha/getCodeImg"
        case .saveBankCardInfo:
            return "/bycx-rece-service/tempBCustBankAcct/saveInfo"
        case .clockList:
            return "/bycx-rece-service/api/sys/code/mobile/query"
        case .preGenarateLoanNo:
            return "/bycx-rece-service/tempBLoanInfo/preGenerateLoanNo"
        case .step1Save:
            return "/bycx-rece-service/tempBCustInfo/saveBaseInfoExt"
        case .checkAuth:
            return "/bycx-rece-service/third/bigData/ecomm/checkAuth"
        case .getAuth:
            return "/bycx-rece-service/third/bigData/ecomm/getAuthUrl"
        case .saveContact:
            return "/bycx-rece-service/tempBCustContctOther/saveContct"
        case .checkContact:
            return "/bycx-rece-service/tempBCustContctOther/query"
        case .saveWork:
            return "/bycx-rece-service/tempBCustWork/save"
        case .checkWork:
            return "/bycx-rece-service/tempBCustWork/getCustWork"
        case .checkIsNeedCollect:
            return "/api/v1/jxl/customer"
        case .passTheData:
            return "/api/v1/jxl/customer"
        case .datasourceOfJLX:
            return "/orgApi/rest/orgs/szbyjr2/datasources"
        case .submitTheJLXForm:
            return "/orgApi/rest/applications/szbyjr2"
        case .submitJLXRequest:
            return "/orgApi/rest/messages/collect/req"
        case .getJLXCollectResp:
            return "/orgApi/rest/messages/collect/resp"
        case .saveProdTrial:
            return "/bycx-rece-service/tempBLoanProd/saveProdTrial"
        case .instNum:
            return "/bycx-prod-service/bPrProdFee/queryProdInstNum"
        case .prodCalc:
            return "/bycx-prod-service/bPrProd/prodCalc"
        case .custProdFee:
            return "/bycx-prod-service/bPrProdFee/queryCustProdFee"
        case .getZhimaAuthUrl:
            return "/bycx-rece-service/third/bigData/Sesame/getOtherZmAuthUrl"
        case .orderList:
            return "/bycx-rece-service/tempBLoanInfo/queryLoanList"
        case .orderDetails:
            return "/bycx-rece-service/tempBLoanInfo/queryLoanDetail"
        case .saveFace:
            return "/bycx-rece-service/third/bigData/saveFaceSimilarity"
        case .myBankCard:
            return "/bycx-rece-service/tempBCustBankAcct/getInfo"
        case .authOnlineBank:
            return "/h5/importV3/index.html#/banklist"
        case .submitApply:
            return "/bycx-rece-service/api/loan/submitData/neworder"
        case .cancelLoanApply:
            return "/bycx-rece-service/tempBLoanInfo/cancelLoan"
        case .getSignUrl:
            return "/bycx-rece-service/third/ssqianService/getSignUrl"
        case .verifyBankCard:
            return "/bycx-rece-service/third/bigData/bank/getBankCardInfo"
        }
    }
}

extension Api {
    
    var fullPath: String {
        var urlString = Constants.serverURL
        switch self {
        case .datasourceOfJLX, .submitTheJLXForm, .submitJLXRequest, .getJLXCollectResp:
            urlString = Constants.serverJLXUrl
        case .checkIsNeedCollect, .passTheData:
            urlString = Constants.ecommerceUrl
        case .authOnlineBank:
            urlString = Constants.authOnlineBankUrl
        default:
            urlString = Constants.serverURL
        }
        return urlString + self.path
    }
}








