//
//  ToastUtils.swift
//  Homer
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import MBProgressHUD

// MBProgressHUD快捷展示
extension UIView {
    
    fileprivate static let HUBHideDelay = 1.5
    
    func showHUD(_ msg : String){
        
        let hub = MBProgressHUD.showAdded(to: self, animated: true)
        hub?.isUserInteractionEnabled = false
        hub?.mode = .text
        hub?.detailsLabelText = msg
        hub?.detailsLabelFont = UIFont.systemFont(ofSize: 16)
        hub?.hide(true, afterDelay: UIView.HUBHideDelay)
    }
    
    func showHudOnWindow(_ msg: String) {
        let window = UIApplication.shared.delegate?.window
        let hub = MBProgressHUD.showAdded(to: window!!, animated: true)
        hub?.mode = .text
        hub?.labelText = msg ?? ""
        hub?.hide(true, afterDelay: UIView.HUBHideDelay)
    }
    
    // 绑定锁的时候用到，其他时候请看情况是否使用
    func showLoadingOnWindow(_ msg: String?) {
        let hub = MBProgressHUD.showAdded(to: Window, animated: true)
        hub?.dimBackground = true
        hub?.labelText = msg ?? ""
    }
    
    func showLoading() {

        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func showLoading(_ msg: String?) {
        let hub = MBProgressHUD.showAdded(to: self, animated: true)
        hub?.labelText = msg
    }
    
    func showLoadingWithDetail(_ msg: String?, detailMsg: String) {
        let hub = MBProgressHUD.showAdded(to: self, animated: true)
        hub?.labelText = msg
        hub?.detailsLabelText = detailMsg
    }
    
    func showLoadingOnWindowWithDetail(_ msg: String?, detailMsg: String) {
        let window = UIApplication.shared.delegate?.window
        let hub = MBProgressHUD.showAdded(to: window!, animated: true)
        hub?.labelText = msg
        hub?.detailsLabelText = detailMsg
    }
    
    func hidAllHud() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
