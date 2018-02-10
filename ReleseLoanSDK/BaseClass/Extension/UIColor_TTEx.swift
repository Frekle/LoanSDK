//
//  UIColor_TTEx.swift
//  TT_Swift
//
//  Created by Lenny on 16/5/11.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //16进制的颜色值
    class func hexColor(_ rgbValue: Int) -> UIColor {
        let red   = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat(rgbValue & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // rgb颜色
    class func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        let randR = CGFloat(arc4random_uniform(255)) / 255.0
        let randG = CGFloat(arc4random_uniform(255)) / 255.0
        let randB = CGFloat(arc4random_uniform(255)) / 255.0
        return UIColor(red: randR, green: randG, blue: randB, alpha: 1)
    }
    
    // 传入字符串
    class func colorWithHex(_ hex:NSString) -> UIColor{
        
        var red:CUnsignedInt = 0, green:CUnsignedInt = 0, blue:CUnsignedInt = 0
        Scanner(string: hex.substring(to: 2)).scanHexInt32(&red)
        let str:NSString = hex.substring(to: 4) as NSString
        Scanner(string: str.substring(from: 2)).scanHexInt32(&green)
        Scanner(string: hex.substring(from: 4)).scanHexInt32(&blue)
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(1))
    }
    
    //颜色转成图片
    class func colorToImage(_ color:UIColor) -> UIImage {
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    open class var dark: UIColor { get { return UIColor.rgb(51, 51, 51) } }
    
    open class var lightGray: UIColor { get { return UIColor.rgb(102, 102, 102) } }
    
    open class var grayText: UIColor { get { return UIColor.rgb(83, 83, 83) } }
    
    open class var placeholder: UIColor { get { return UIColor.rgb(153, 153, 153) } }
    
    open class var theme: UIColor { get { return UIColor.rgb(255, 103, 1) } }
    
    open class var lightTheme: UIColor { get { return UIColor.rgb(255, 65, 0) } }
    
    open class var price: UIColor { get { return UIColor.hexColor(0xf37157) } }
    
    open class var top: UIColor { get { return UIColor.hexColor(0xde3031) } }
    
    open class var line: UIColor { get { return UIColor.hexColor(0xe1e1e1) } }
    
    open class var view: UIColor { get { return UIColor.hexColor(0xf0f1f2) } }
    
    
    
    
    
    open class var timeDesc: UIColor { get { return UIColor.hexColor(0x666666) } }
    
    open class var lightGreenDesc: UIColor { get { return UIColor.hexColor(0xc8ffe8) } }
    
    open class var backGray: UIColor { get { return UIColor.hexColor(0xf1f1f1) } }
    
    open class var wlGreen: UIColor { get { return UIColor.hexColor(0x1bbc9b) } }
    
    open class var yxGreen: UIColor { get { return UIColor.hexColor(0x84c351) } }
    
    open class var lightGreen: UIColor { get { return UIColor.hexColor(0x67ddab) } }
    
    open class var darkGreen: UIColor { get { return UIColor.hexColor(0x62d1a2) } }
    
    open class var pic: UIColor { get { return UIColor.hexColor(0xf1f1f1) }}
    
    open class var wlYellow: UIColor { get { return UIColor.hexColor(0xffc220)}}
    
    open class var wlBlack: UIColor { get { return UIColor.hexColor(0x333333)}}
    
    open class var wlRed: UIColor { get { return UIColor.hexColor(0xff2c2a) } }
    
    open class var wlGray: UIColor { get { return UIColor.hexColor(0xf3f2f0) } }
    
    open class var wlBlue: UIColor { get { return UIColor.hexColor(0x4d90e7) } }
    
    open class var wlPint: UIColor { get { return UIColor.hexColor(0xdb7093) } }
    
    open class var darkOrange: UIColor { get { return UIColor.hexColor(0xff6800) } }
    
    open class var lightOrange: UIColor { get { return UIColor.hexColor(0xff8938) } }
    
    open class var orangeDesc: UIColor { get { return UIColor.hexColor(0xFABE9B) } }
}
