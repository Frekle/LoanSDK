//
//  TabBarVC.swift
//  UTOO
//
//  Created by Lenny on 16/9/23.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import UIKit

public class TabBarViewController: UITabBarController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "注册任信用，最高领取5万额度"
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        self.UI()
    }
    
    func UI() {
        let homeVC = HomeViewController()
        homeVC.title = "注册任信用，最高领取5万额度"
        let mineVC = MineViewController()
        mineVC.title = "注册任信用，最高领取5万额度"
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        let mineNav = BaseNavigationController(rootViewController: mineVC)
        viewControllers = [homeNav, mineNav]
        let titles:[NSString] = ["借款", "我的"]
        let images:[String] = ["tab_btn_jiekuan_nomal", "tab_btn_wode_normal"];
        let selectImgs:[String] = ["tab_btn_jiekuan_selected", "tab_btn_wode_selected"];
        
        for item:UITabBarItem in self.tabBar.items! {
            let index = self.tabBar.items!.index(of: item)
            item.title = titles[index!] as String
            item.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.placeholder],for: UIControlState.selected)
            item.image = UIImage.init(named: images[index!])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.selectedImage = UIImage.init(named: selectImgs[index!])?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
//        self.setNaviBarStyle()
//        self.setTabBarStyle()
    }
    
//    func addNaviVC(vc:UIViewController) -> BaseNavigationController {
//        let naviVC = BaseNavigationController(rootViewController: vc)
//        return naviVC
//    }
    
    //设置tabbar的样式
//    func setTabBarStyle() {
//        self.tabBar.backgroundImage = UIColor.colorToImage(UIColor.white)
//        self.tabBar.shadowImage = UIColor.colorToImage(UIColor.line)
//    }
//
//    //设置navibar的样式
//    func setNaviBarStyle() {
//        UINavigationBar.appearance().setBackgroundImage(UIColor.colorToImage(UIColor.white), for: UIBarMetrics.default)
//        //        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.wlBlack]
//        UINavigationBar.appearance().tintColor = UIColor.wlBlack
//        UINavigationBar.appearance().isTranslucent = false
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//    }
    
}
