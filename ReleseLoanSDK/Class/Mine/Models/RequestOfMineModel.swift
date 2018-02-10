//
//  RequestOfMineModel.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/6.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

public protocol FKOrderStatusCode {
    var stringValue: String {get}
}

/*31000001  退单
 31000002    已签约
 31000003   取消
 31000004    通过
 31000005    不通过
 31000006   返回销售修改
 31000007   撤销
 31000008    审批中
 31000009   未签约
 31000010   签约失败
 31000012  未提交
 31000017   资方待审核
 31000011   待审批
 31000013   审核中*/
enum OrderStatus: Int {
    case chargeback = 31000001
    case signed = 31000002
    case cancel = 31000003
    case passed = 31000004
    case unpass = 31000005
    case returnSell = 31000006
    case undo = 31000007
    case approving = 31000008
    case notSign = 31000009
    case failSign = 31000010
    case unsubmit = 31000012
    case employerPendingReview = 31000017
    case pendingReview = 31000011
    case underReview = 31000013
    case refused = 31000014
    case machineTrial = 31000015
    case machineTrialUnpass = 31000016
    case inLending = 31000018
    case loanSucess = 31000019
}

extension OrderStatus: FKOrderStatusCode {
    var stringValue: String {
        switch self {
        case .chargeback: return "退单"
        case .signed: return "已签约"
        case .cancel: return "取消"
        case .passed: return "通过"
        case .unpass: return "不通过"
        case .returnSell: return "返回销售修改"
        case .undo: return "撤销"
        case .approving: return "审批中"
        case .notSign: return "未签约"
        case .failSign: return "签约失败"
        case .unsubmit: return "未提交"
        case .employerPendingReview: return "资方待审核"
        case .pendingReview: return "待审批"
        case .underReview: return "审核中"
        case .refused: return "退单"
        case .machineTrial: return "待机审"
        case .machineTrialUnpass: return "机审不通过"
        case .inLending: return "放款中"
        case .loanSucess: return "放款成功"
        }
    }
}

struct RequestOfMineModel {

    static func requestMineOrders(status: OrderStatus?, callback: @escaping ([OrderData])->()) {
        if let status = status {
            NetWorkManager.request(api: .orderList(status: "\(status.rawValue)"), successHandler: { (data: BaseModel<OrderData>) in
                guard let orderData = data.datas else{return}
                callback(orderData)
            }) { (error) in
                
            }
        } else {
            NetWorkManager.request(api: .orderList(status: nil), successHandler: { (data: BaseModel<OrderData>) in
                guard let orderData = data.datas else{return}
                callback(orderData)
            }) { (error) in
                
            }
        }
    }
    
    static func requestOrderDetails(loanNo: String, callback: @escaping (OrderDetailData)->()) {
        NetWorkManager.request(api: .orderDetails(loanNo: loanNo), successHandler: { (data: BaseModel<OrderDetailData>) in
            guard let orderData = data.data else{return}
            callback(orderData)
        }) { (error) in
            
        }
    }
    
    static func changePassword(oldPass: String, newPass: String, callback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.changePassword(phone: UserInfo.shared().user?.loginNo ?? "", passwd: newPass, oldPassword: oldPass), successHandler: { (data: BaseData) in
            if data.resultString == "0000" {
                callback()
            }
        }) { (error) in
            
        }
    }
    
    static func getMyBankCardInfo(callback: @escaping (MyBankCardData?) -> ()) {
        NetWorkManager.request(api: Api.myBankCard, successHandler: { (data: BaseModel<MyBankCardData>) in
            callback(data.data)
        }) { (erorr) in
            
        }
    }
    
    // 取消申请
    static func cancelApply(loanNo: String, callback: @escaping (Bool) -> ()) {
        NetWorkManager.request(api: Api.cancelLoanApply(loanNo: loanNo), successHandler: { (data: BaseData) in
            callback(data.resultBool)
        }) { (erorr) in
            
        }
    }
    // 获取签约地址
    static func getSignUrl(loanNo: String, callback: @escaping ([SignUrlData]) -> ()) {
        NetWorkManager.request(api: Api.getSignUrl(loanNo: loanNo), successHandler: { (data: BaseModel<SignUrlData>) in
            guard let result = data.datas else{return}
            callback(result)
        }) { (erorr) in
            
        }
    }
}
