//
//  NaviVC.swift
//  UTOO
//
//  Created by 王亮 on 2016/11/8.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import UIKit

public class BaseNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor.dark
        navigationBar.isTranslucent = false
        
        navigationBar.backIndicatorImage = UIImage(named: "nav_btn_fanhuijiantou_normal")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_btn_fanhuijiantou_normal")
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        var fromVC:UIViewController? = nil
        if self.viewControllers.count > 0 {
            fromVC = self.viewControllers.last!
            fromVC?.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
        //viewControllers要加1

        if self.viewControllers.count > 0 {
            if self.viewControllers.count == 2 {
                fromVC?.hidesBottomBarWhenPushed = false
            }
        }
    }
}
