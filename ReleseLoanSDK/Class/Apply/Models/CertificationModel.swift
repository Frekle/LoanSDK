//
//  CertificationModel.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/24.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

struct CertificationModel {
    
    static func faceIdToken(callBack: @escaping (FaceIdTokenData) -> Void) {
        FaceIdNetwork.request(api: .getFaceIdToken, successHandler: { (data: FaceIdTokenData) in
            callBack(data)
        }) { (error) in
        }
    }
    
    static func doVertification(token: String, callBack: @escaping (String) -> Void) {
        FaceIdNetwork.request(api: .doVertification(token: token), successHandler: { (data: BaseData) in
            
        }, webSucccessHandler: { (webString) in
            callBack(webString)
        }) { (error) in
            
        }
    }
    
    static func getResult(bizId: String, callback: @escaping (FaceIdResultData) -> Void) {
        FaceIdNetwork.request(api: .getResult(bizId: bizId), successHandler: { (data: FaceIdResultData) in
            callback(data)
        }) { (error) in
            
        }
    }
    
    static func saveBankCard(account: String, acctName: String, openOrg: String, openProv: String, openCity: String, openAddr: String, bankType: String, callback: @escaping (BaseData) -> Void) {
        NetWorkManager.request(api: Api.saveBankCardInfo(phone: UserInfo.shared().user!.loginNo, acctNo: account, acctName: acctName, openOrg: openOrg, openProv: openProv, openCity: openCity, openAddr: openAddr, bankType: bankType), successHandler: { (data: BaseData) in
            callback(data)
        }) { (error) in
            
        }
    }
    
    static func checkList(typeNames: [String], callback: @escaping (BaseTypeModel) -> Void) {
        Window?.showLoading()
        NetWorkManager.request(api: Api.clockList(list: typeNames), successHandler: { (data: BaseModel<BaseTypeModel>) in
            Window?.hidAllHud()
            guard let result = data.data else{return}
            callback(result)
        }) { (data) in
        }
    }
    
    static func saveUserInfoStep1(phone: String, custName: String, sex: String, workJob: String, ethnic: String, marriage: String, certNo: String, certOrg: String, certValidDate: String, regProv: String, regCity: String, regArea: String, regAddr: String, liveProv: String, liveCity: String, liveArea: String, liveAddr: String, qq: String, edu: String, callback: @escaping ((String) -> Void)) {
        NetWorkManager.request(api: Api.step1Save(phone: phone, custName: custName, sex: sex, workJob: workJob, ethnic: ethnic, marriage: marriage, certNo: certNo, certOrg: certOrg, certValidDate: certValidDate, regProv: regProv, regCity: regCity, regArea: regArea, regAddr: regAddr, liveProv: liveProv, liveCity: liveCity, liveArea: liveArea, liveAddr: liveAddr, qq: qq, edu: edu), successHandler: { (data: BaseData) in
            callback(data.resultString)
        }) { (error) in
            
        }
    }
    
    /** 验证是否授权电商/京东 */
    static func checkAuth(authItem: String, callback: @escaping (Bool) -> Void) {
        NetWorkManager.request(api: Api.checkAuth(authItem: authItem), successHandler: { (data: BaseModel<AuthData>) in
            guard let resultData = data.data else{return}
            callback(resultData.isAuth ?? false)
        }) { (error) in
            
        }
    }
    
    /** 获取电商/京东授权接口 */
    static func getAuth(authItem: String, callback: @escaping (String) -> Void) {
        NetWorkManager.request(api: Api.getAuth(authItem: authItem), successHandler: { (data: BaseModel<AuthData>) in
            guard let resultData = data.data else{return}
            callback(resultData.authUrl ?? "")
        }) { (error) in
            
        }
    }
    
    /** 保存联系人信息 */
    static func saveContactInfo(contacts: [ContactData], callBack: @escaping (() -> ())) {
        NetWorkManager.request(api: Api.saveContact(list: contacts), successHandler: { (data: BaseData) in
            if data.resultString == "0000" {
                callBack()
            }
        }) { (error) in
            
        }
    }
    
    /** 预生成贷款标号 */
    static func preGenrateLoanNo(no: String) {
        NetWorkManager.request(api: Api.preGenarateLoanNo(prodNo: no), successHandler: { (data: BaseData) in
            
        }) { (error) in
            
        }
    }
    
    /** 是否需要手机认证 */
    static func isNeedMobileCertification(callback: @escaping (Bool) -> Void, errorCallback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.checkIsNeedCollect(userId: UserInfo.shared().loanNo, account: UserInfo.shared().user?.loginNo ?? "", website: "mobile"), successHandler: { (data: BaseData) in
            guard let result = data.tempData?.result else{return}
            callback(result)
        }) { (error) in
            errorCallback()
        }
    }
    
    /** 采集成功后将数据传递给数据部 */
    static func passTheData(token: String, phone: String, callback: @escaping (BaseData) -> Void) {
        NetWorkManager.request(api: Api.passTheData(token: token, phone: phone), successHandler: { (data: BaseData) in
            
        }) { (error) in
            
        }
    }
    
    /** 客户可选的产品费用项查询接口:暂时不用 */
//    static func queryCustProdFee(instNum: String, callback: @escaping ([ProdListData]) -> Void) {
//        NetWorkManager.request(api: Api.custProdFee(instNum: instNum), successHandler: { (data: BaseModel<ProdListData>) in
//            guard let datas = data.datas else{return}
//            callback(datas)
//        }) { (error) in
//
//        }
//    }
    
    /** 产品试算 */
    static func prodCalc(instNum: String, goodsAmt: String, payAmt: String, feeNos: String, callback: @escaping ([ProdData]) -> Void) {
        NetWorkManager.request(api: Api.prodCalc(prodNo: Constants.prodNumber, instNum: instNum, goodsAmt: goodsAmt, payAmt: payAmt, feeNos: feeNos), successHandler: { (data: BaseModel<ProdData>) in
            guard let datas = data.datas else{return}
            callback(datas)
        }) { (error) in
            
        }
    }
    
    /** 产品试算保存接口 */
    static func saveProdTrial(inst: String, loanAmt: String, mthRepay: String, fstRepay: String, feeList: [String], callback: @escaping ((String)->())) {
        NetWorkManager.request(api: Api.saveProdTrial(custName: UserInfo.shared().user?.loginNo ?? "", instNum: inst, loanAmt: loanAmt, mthRepayAmt: mthRepay, fstRepayDate: fstRepay, feeList: feeList), successHandler: { (data: BaseModel<LoanNumberData>) in
            guard let loanData = data.data else{return}
            callback(loanData.loanNo)
        }) { (error) in

        }
    }
    
    /**  人脸识别相似度保存接口*/
    static func saveFaceSimilary(idcard: String, name: String, score: String, callback: @escaping (Bool) -> Void) {
        NetWorkManager.request(api: Api.saveFace(idCard: idcard, name: name, score: score), successHandler: { (data: BaseModel<SaveFaceidSimilaryData>) in
            guard let result = data.data else{return}
            callback(result.isSave)
        }) { (data) in
            
        }
    }
    
    /** 产品期数 */
    static func instNum(callback: @escaping ([String]) -> Void) {
        NetWorkManager.request(api: Api.instNum(prodNo: "60203"), successHandler: { (data: InstListData) in
            guard let list = data.instList else{return}
            callback(list)
        }) { (data) in
            
        }
    }
    
    static func getZhiMaUrl(callback: @escaping (String) -> Void) {
        NetWorkManager.request(api: Api.getZhimaAuthUrl, successHandler: { (data: BaseData) in
            callback(data.resultString)
        }) { (data) in
            
        }
    }
    
    // 保存公司信息接口
    static func saveWorkInfo(unitName: String, unitTel: String, industry: String, workPost: String, workJob: String, unitProv: String, unitCity: String, unitArea: String, unitAddr: String, callback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.saveWork(unitName: unitName, unitTel: unitTel, industry: industry, workPost: workPost, workJob: workJob, unitProv: unitProv, unitCity: unitCity, unitArea: unitArea, unitAddr: unitAddr), successHandler: { (data: BaseData) in
            if data.resultString == "0000" {
                callback()
            }
        }) { (error) in
            
        }
    }
    
    // 1.1.1    获取支持的数据源列表
    static func getJLXdataSource(callback: @escaping ([JLXDataSourceData]) -> (), errorCallback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.datasourceOfJLX, successHandler: { (data: BaseModel<JLXDataSourceData>) in
            guard let jlxData = data.jlxDatas else{return}
            callback(jlxData)
        }) { (error) in
            errorCallback()
        }
    }
    
    // 提交聚立信表单
    static func submitJLXform(phone: String, callback: @escaping (JLXMobileOperatorData) -> (), errorCallback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.submitTheJLXForm(phone: phone), successHandler: { (data: BaseModel<JLXMobileOperatorData>) in
            guard let jlxData = data.jlxData else{return}
            callback(jlxData)
        }) { (error) in
            errorCallback()
        }
    }
    
    // 提交采取请求(发送验证码)
    static func submitJLXRequest(token: String, account: String, password: String, captcha: String, website: String, type: CaptchaType, callback: @escaping (Bool) -> (), errorCallback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.submitJLXRequest(token: token, account: account, password: password, captcha: captcha, type: type, website: website), successHandler: { (data: TempBaseData) in
//            guard let jlxData = data.jlxData else{return}
            callback(data.result)
        }) { (error) in
            errorCallback()
        }
    }
    
    // 获取采集响应信息
    static func getJLXCollectResp(token: String, account: String, password: String, captcha: String, website: String, type: CaptchaType, callback: @escaping (JLXCollectRespData) -> (), errorCallback: @escaping () -> ()) {
        NetWorkManager.request(api: Api.getJLXCollectResp(token: token, account: account, password: password, captcha: captcha, type: type, website: website), successHandler: { (data: BaseModel<JLXCollectRespData>) in
            guard let jlxData = data.jlxData else{return}
            callback(jlxData)
        }) { (error) in
            errorCallback()
        }
    }
    
    // 提交贷款产品申请
    static func submitApply(callback: @escaping (String) -> ()) {
        NetWorkManager.request(api: Api.submitApply, successHandler: { (data: BaseData) in
            callback(data.resultString)
        }) { (error) in
            
        }
    }
    
    // 校验银行卡
    static func verifyBankCard(bankCard: String, name: String, callback: @escaping (BankInfoData) -> ()) {
        NetWorkManager.request(api: Api.verifyBankCard(bankCard: bankCard, name: name), successHandler: { (data: BaseModel<BankCardInfoData>) in
            guard let result = data.data?.bankInfo else{return}
            callback(result)
        }) { (error) in
            
        }
    }
}






