//
//  AppDelegate.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/12.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

/*
 9.sdk
 
 // 任信用注意事项
 用户年龄18-50才能办理
 相似度大于70才能通过，
 保存人脸最佳识别图片，第三步上传
 网银认证选择信用卡时：需要做银行卡四要素
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        //        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    
    
}

