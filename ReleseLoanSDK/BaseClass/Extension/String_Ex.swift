//
//  String_Ex.swift
//  UTOO
//
//  Created by Lenny on 16/9/24.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func substringToIndex(index: Int) -> String {
        return String(self[self.startIndex..<self.index(self.startIndex, offsetBy: index)])
    }
    
    func substringFromIndex(index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)..<self.endIndex])
    }
    
    func substringWithRange(start: Int, end: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: end)])
    }
    
    func parasingWebStringToDic() -> Dictionary<String, String> {
        var dic = Dictionary<String, String>()
        let urlString = self as NSString
        let range = urlString.range(of: "?")
        if range.length > 0 {
            let locationString = urlString.substring(from: range.location + 1)
            let array = locationString.components(separatedBy: "&")
            array.forEach { (dicString) in
                let arr = dicString.components(separatedBy: "=")
                dic[arr.first ?? ""] = arr.last
            }
        }
        return dic
    }
    
    /** 根据文本计算高度 */
    func getTextRectSize(_ font:UIFont, size:CGSize) -> CGRect {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
    func stringSize(font:UIFont)->CGSize {
        return self.stringSize(markSize: CGSize.init(width:CGFloat.greatestFiniteMagnitude , height: CGFloat.greatestFiniteMagnitude), font: font)
    }
    
    func stringSize(markSize:CGSize ,font:UIFont) -> CGSize {
        
        var str:NSString = self as NSString
        if str.integerValue < 10 {
            str = NSString.init(string: "0" + self)
        }
        let size = str.boundingRect(with: markSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil).size
        return size
    }
    
    func stringToNSNumber() -> NSNumber {
        
        let str:NSString = self as NSString
        let num = NSNumber.init(value: str.floatValue)
        return num
    }
    
    func toDic() -> NSDictionary? {
        
        var jsonString = self
        jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        jsonString = jsonString.replacingOccurrences(of: " ", with: "")
        jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
        jsonString = jsonString.replacingOccurrences(of: "=", with: ":")
        jsonString = jsonString.replacingOccurrences(of: ";", with: ",")
        let data = jsonString.data(using: .utf8)
        guard let datas = data else {return nil}
        let dic = try? JSONSerialization.jsonObject(with: datas, options: JSONSerialization.ReadingOptions.mutableContainers)
        return dic as? NSDictionary ?? nil
    }
    func JSONtoDic() -> NSDictionary? {
        
        
        var jsonString = self
        jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let data = jsonString.data(using: .utf8)
        guard let datas = data else {return nil}
        let dic = try? JSONSerialization.jsonObject(with: datas, options: JSONSerialization.ReadingOptions.mutableContainers)
        return dic as? NSDictionary ?? nil
    }
    
    
    // 字符串转钱
    func money() -> String {
        return "￥" + String(format: "%.2f", isNull(self).stringToNSNumber().floatValue)
    }
    // 字符串转int
    func stringToInt(str:String)->(Int){
        
        let string = str
        var int: Int?
        if let doubleValue = Int(string) {
            int = Int(doubleValue)
        }
        if int == nil
        {
            return 0
        }
        return int!
    }
    // 折扣
    func keepFloatPlaces(digit: Int) -> String {
        return ""
//        return String(format: "%.\(digit)f", isNull(self).stringToNSNumber().floatValue)
    }
    
    func idCardNumber() -> String {
        var resultStr = ""
        var index = 0
        let strCount = self.characters.count
        self.characters.forEach { (item) in
            index += 1
            if (index > 0 && index <= 3) || (index <= strCount && index > strCount - 3){
                resultStr.append(item)
            } else {
                resultStr.append("*")
            }
        }
        return resultStr
    }
    
    // 格式化时间
    func time(dateFormat: String) -> String {
        
        let date = Date(timeIntervalSinceNow: TimeInterval(self) ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    func timeSince1970(dateFormat: String) -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(self) ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }

    /**   这个方法没有多大用，系统API已经提供了很多方法给我们如上
     *  URL 编码
     *   return 编码字符串
     */
    func encodeEscapesURL(value: String) -> String {
        let str:String = value
        let originalString = str as CFString
        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFString  //":/?&=;+!@#$()',*"    //转意符号
        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号
        let result =
            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                    originalString,
                                                    nil,    //charactersToLeaveUnescaped,
                charactersToBeEscaped,
                CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) as NSString
        return result as String
    }
    /**
     *  URL 解码
     *   return 解码字符串
     */
    func stringByURLDecode() -> String {
        if self.removingPercentEncoding != nil {
            return self.removingPercentEncoding!
        } else {
            let en: CFStringEncoding = CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)
            var decoded: String = self.replacingOccurrences(of: "+", with: " ")
            decoded = (CFURLCreateStringByReplacingPercentEscapesUsingEncoding(nil, (decoded as CFString),nil, en) as String)
            return decoded
        }
    }
    
    //验证手机号码
    func isMobile() -> Bool {
        let phoneRegex = "[1][23456789]\\d{9}"
        let tempPhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return tempPhone.evaluate(with: self)
    }
    
    func isStringNotEmpty() -> Bool {
        return count > 0
    }
}

extension String {
    func matchWithRegExp(_ pattern: String) -> Bool {
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }
        return regExp.firstMatch(in: self, options: .anchored, range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
    
    var isValidPhoneNumber: Bool {
        return matchWithRegExp("^1\\d{10}$")
    }
    
    var isValidLoginPassword: Bool {
        return matchWithRegExp("^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$")
    }
}

extension TimeInterval {
    func timeIntervalString() -> String {
        let day = Int(self / 3600 / 24)
        let hours = Int((self - Double(day) * 24 * 3600) / 3600)
        let minute = Int((self - Double(day) * 24 * 3600 - Double(hours) * 3600) / 60)
        
        let dayStr = String(format: "%02i", day)
        let hoursStr = String(format: "%02i", hours)
        let minuteStr = String(format: "%02i", minute)
        return dayStr + "天" + hoursStr + "时" + minuteStr + "分"
    }
}
