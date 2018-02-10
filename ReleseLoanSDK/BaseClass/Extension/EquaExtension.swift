//
//  EquaExtension.swift
//  UTOO
//
//  Created by Frekle on 2017/2/9.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation

extension Equatable {
    func isIn<T: Sequence>(_ collection: T) -> Bool where T.Iterator.Element == Self {
        return collection.contains(self)
    }
    
    func isIn(_ collection: Self...) -> Bool {
        return collection.contains(self)
    }
}

extension Dictionary {
    func toJsonString() -> String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
//            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }
    
    func parsingParams() -> String {
        var paramString = "?"
        var index = 0
        self.forEach { (key, value) in
            index += 1
            paramString.append("\(key)=\(value)")
            if index < self.count {
                paramString.append("&")
            }
        }
        if paramString == "?" {
            return ""
        }
        return paramString
    }
}

extension NSDictionary {
    
    func toJson() -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) else{return ""}
        
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
}

extension NSArray {
    
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
