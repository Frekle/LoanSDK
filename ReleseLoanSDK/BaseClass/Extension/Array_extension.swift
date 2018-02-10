//
//  Array_extension.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/2/9.
//  Copyright © 2018年 None. All rights reserved.
//

import Foundation

extension Array {
    
    func toJson() -> String {
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) else{return ""}
        //        NSJSONWritingOptions.PrettyPrinted
        var jsonString = String(data: jsonData, encoding: .utf8) ?? ""
        jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        jsonString = jsonString.replacingOccurrences(of: " ", with: "")
        jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
        return jsonString
    }
}
