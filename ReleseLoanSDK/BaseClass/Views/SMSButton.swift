//
//  GetAuthCodeBtn.swift
//  HomerEU
//
//  Created by Wang on 16/4/13.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

enum SMSButtonTime : String{
    case WhenRegister        = "SMSButtonRegisterKey"
    case WhenForgetPassword  = "SMSButtonForgetPasswordKey"
    case WhenApplyForTempKey = "SMSButtonApplyForTempKeyKey"
    case WhenAddNewUser      = "SMSButtonAddNewUserKey"
    case WhenGetInvite       = "SMSButtonGetInviteKey"
    case WhenAcceptInvite    = "SMSButtonAcceptInviteKey"
    case WhenDeleteMember    = "SMSButtonDeleteMemberKey"
    case WhenFindPayPassword = "SMSButtonFindPayPasswordKey"
}

class SMSButton: UIButton {
    
    fileprivate enum SMSButtonState{
        case sending
        case waiting
        case normal
    }
    // MARK: properties
    fileprivate let userDefaultsKey : String!
    
    fileprivate var timer: Timer? {
        willSet {
            timer?.invalidate()
        }
    }
    
    var didTouchUpInsideCallback : (() -> Void)?
    let style: SMSButtonStyle
    
    fileprivate let defaultSeconds : TimeInterval = 60
    fileprivate var buttonState = SMSButtonState.normal{
        didSet{
            switch buttonState {
            case .normal:
                style.normalState(self)
            case .waiting:
                style.waitingState(self)
            case .sending:
                style.sendingState(self)
            }
        }
    }
    
    fileprivate var lastTimeSendCode : Date = Date.init(timeIntervalSince1970: 0){
        didSet{
            UserDefaults.standard.setValue(Date.init(timeIntervalSinceNow: 0), forKey: userDefaultsKey)
        }
    }
    
    // MARK: init
    // design init
    init(time: SMSButtonTime, smsButtonStyle: SMSButtonStyle?){
        userDefaultsKey = time.rawValue
        style = smsButtonStyle ?? NormalSMSButtonStyle()
        super.init(frame: CGRect.zero)
        self.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        self.titleLabel?.font = UIFont.size14
        self.layer.cornerRadius = Scale.height(15)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.rgb(255, 103, 1).cgColor
        style.normalState(self)
        if let lastTime = UserDefaults.standard.value(forKey: userDefaultsKey) as? Date{
            self.lastTimeSendCode = lastTime
            setATimer()
        }
    }
    
    // convi
    
    convenience init(time: SMSButtonTime){
        self.init(time: time, smsButtonStyle: nil)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    @objc func didTouchUpInside(){
        if self.buttonState == .normal{
            self.buttonState = .sending
            didTouchUpInsideCallback?()
        }
    }
    
    func beginAnimated(){
        lastTimeSendCode = Date(timeIntervalSinceNow: 0)
        UserDefaults.standard.setValue(Date(timeIntervalSinceNow: 0), forKey: userDefaultsKey)
        setATimer()
    }
    
    func toNormalState(){
        self.buttonState = .normal
    }
    
    fileprivate func setATimer(){
        if -lastTimeSendCode.timeIntervalSinceNow < defaultSeconds {
            self.buttonState = .waiting
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SMSButton.respondsToTimer(_:)), userInfo: nil, repeats: true)
            
            timer?.fireDate = Date.distantPast
        }
    }
    
    @objc func respondsToTimer(_ timer : Timer){
        let timeInterval = lastTimeSendCode.timeIntervalSinceNow + defaultSeconds
        if timeInterval > 0{
            setAttributedTitleString("\(Int(round(timeInterval)))s", forState: UIControlState())

        }else{
            timer.invalidate()
            toNormalState()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIButton {
    
    func setAttributedTitleString(_ string: String , forState state : UIControlState){
        guard let oldAttStr = attributedTitle(for: state) else { return }
        let attStr = NSMutableAttributedString(attributedString: oldAttStr)
        attStr.mutableString.setString(string)
        setAttributedTitle(attStr, for: state)
    }
    
//    class func buttonWithTitle(title: String, font: UIFont) -> UIButton {
//        let button = UIButton(type: .Custom)
//        button.setTitle(title, forState: .Normal)
//        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        button.titleLabel?.font = font
//        return button
//    }
}
