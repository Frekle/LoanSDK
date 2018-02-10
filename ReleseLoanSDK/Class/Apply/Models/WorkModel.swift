//
//  WorkModel.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/27.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseTypeModel: BaseData {
    
    var sex: [TypeModel]?
    var work_job: [TypeModel]?
    var live_build_type: [TypeModel]?
    var relation: [TypeModel]?
    var education: [TypeModel]?
    var unit_scale: [TypeModel]?
    var open_org: [TypeModel]?
    var is_no: [TypeModel]?
    var goods_type: [TypeModel]?
    var first_pay_type: [TypeModel]?
    var atta_type: [TypeModel]?
    var stat: [TypeModel]?
    var industry: [TypeModel]?
    var unit_type: [TypeModel]?
    var position_level: [TypeModel]?
    var mobile_time: [TypeModel]?
    var month_avg_fee: [TypeModel]?
    var marriage_status: [TypeModel]?
    var educational_system: [TypeModel]?
    var contract_type: [TypeModel]?
    var aprov_result: [TypeModel]?
    var call_type: [TypeModel]?
    var nation: [TypeModel]?
    var source_type: [TypeModel]?
    var source_user_type: [TypeModel]?
    var source_os_type: [TypeModel]?
    var is_installment: [TypeModel]?
    var loan_use: [TypeModel]?
    var bank_type: [TypeModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        sex <- map["sex"]
        work_job <- map["work_job"]
        live_build_type <- map["live_build_type"]
        relation <- map["relation"]
        education <- map["education"]
        unit_scale <- map["unit_scale"]
        open_org <- map["open_org"]
        is_no <- map["is_no"]
        goods_type <- map["goods_type"]
        first_pay_type <- map["first_pay_type"]
        atta_type <- map["atta_type"]
        stat <- map["stat"]
        industry <- map["industry"]
        unit_type <- map["unit_type"]
        position_level <- map["position_level"]
        mobile_time <- map["mobile_time"]
        month_avg_fee <- map["month_avg_fee"]
        marriage_status <- map["marriage_status"]
        educational_system <- map["educational_system"]
        contract_type <- map["contract_type"]
        aprov_result <- map["aprov_result"]
        call_type <- map["call_type"]
        nation <- map["nation"]
        source_type <- map["source_type"]
        source_user_type <- map["source_user_type"]
        source_os_type <- map["source_os_type"]
        is_installment <- map["is_installment"]
        loan_use <- map["loan_use"]
        bank_type <- map["bank_type"]
    }
    
}

class TypeModel: BaseData {

    var valCode = ""
    var valName = ""
    var instDate = 0
    var remark = ""
    var updtDate = ""
    var id = ""
    var typeCode = ""
    var status = ""
    var instUserNo = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        valCode <- map["valCode"]
        valName <- map["valName"]
        instDate <- map["instDate"]
        remark <- map["remark"]
        updtDate <- map["updtDate"]
        id <- map["id"]
        typeCode <- map["typeCode"]
        status <- map["status"]
        instUserNo <- map["instUserNo"]
        
    }
}
