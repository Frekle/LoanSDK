//
//  SMSButtonStyle.swift
//  HomerEU
//
//  Created by 崔皓 on 16/6/5.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

protocol SMSButtonStyle {
    func normalState(_ smsButton: SMSButton)
    func waitingState(_ smsButton: SMSButton)
    func sendingState(_ smsButton: SMSButton)
}


struct NormalSMSButtonStyle: SMSButtonStyle {
    fileprivate var disenableColor = UIColor.lightGray
    fileprivate var enableColor = UIColor.theme
    var underLineColor = UIColor.white
    
    init() { }
    
    init(enableColor: UIColor, disenableColor: UIColor, underLineColor: UIColor? = nil) {
        self.enableColor    = enableColor
        self.disenableColor = disenableColor
    }
    
    func normalState(_ smsButton: SMSButton) {
        
        let attString = NSMutableAttributedString(string: "获取验证码", attributes: [NSAttributedStringKey.font : UIFont.size14, NSAttributedStringKey.foregroundColor : enableColor])

        smsButton.setAttributedTitle(attString, for: UIControlState())
    }
    
    func waitingState(_ smsButton: SMSButton) {
        let attString = NSMutableAttributedString(string: "正在发送...", attributes: [NSAttributedStringKey.font : UIFont.size14,NSAttributedStringKey.foregroundColor : disenableColor])

        smsButton.setAttributedTitle(attString, for: UIControlState())
    }
    
    func sendingState(_ smsButton: SMSButton) {
        if let currentAttributedTitle = smsButton.currentAttributedTitle{
            let attString = NSMutableAttributedString(attributedString: currentAttributedTitle)
            attString.addAttribute(NSAttributedStringKey.foregroundColor, value: disenableColor, range: NSRange(location: 0, length: attString.length))
            smsButton.setAttributedTitle(attString, for: UIControlState())
        }
    }
}
