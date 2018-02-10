//
//  ContactData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/5.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ContactData: BaseData {
    var phoneNo = UserInfo.shared().user?.loginNo ?? ""
    var contactName = ""
    var contactRel = ""
    var contactTel = ""
//    var contactAdd = ""
    
    convenience init(name: String, rel: String, tel: String) {
        self.init()
        contactName = name
        contactRel = rel
        contactTel = tel
    }
    
    func todic() -> [String: String] {
        return ["phoneNo": phoneNo,
                "contactName": contactName,
                "contactRel": contactRel,
                "contactTel": contactTel]
//                "contactAdd": contactAdd]
    }
}
