//
//  BaseViewController.swift
//  UTOO
//
//  Created by Lenny on 16/9/22.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import UIKit
//import RxSwift

//protocol RemovableProtocal {
//    var countOfShouldRemove: Int?
//}

public class BaseViewController: UIViewController {

    //类型
    var wl_type:String?
    var countOfShouldRemove: Int = 0
//    var disposeBag = DisposeBag()
    
    // MARK: Initialing
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.view
        let backBtn = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backBtnAction))
        navigationItem.backBarButtonItem = backBtn
        
        initUserInterface()
        initDataSource()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        removeViewControllers(countOfShouldRemove)
//        countOfShouldRemove = 0
//    }
    
    /**
     删除导航控制器栈中的视图
     
     - parameter count: 要删除的视图数量
     */
//    func removeViewControllers(_ count: Int) {
//        if count > 0 {
//            if let navi = self.navigationController {
//                let totalCount = navi.viewControllers.count
//                self.navigationController?.viewControllers.removeSubrange((totalCount - count - 1)..<(totalCount - 1))
//            }
//        }
//    }
    
    override open func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
//        self.extendedLayoutIncludesOpaqueBars = false
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func backBtnAction() {

    }
    
    // MARK: Layout Constraints
//    private(set) var didSetupConstraints = false
//    
//    override func updateViewConstraints() {
//        if !self.didSetupConstraints {
//            self.setupConstraints()
//            self.didSetupConstraints = true
//        }
//        super.updateViewConstraints()
//    }
    
    func setupConstraints() {
        // Oberride point
    }
    
    func initUserInterface() {
        // Oberride point
        view.backgroundColor = UIColor.white
//        prefersLargeTitles = true
//        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
//                                         action: #selector(popViewController))
//        leftBarBtn.image = UIImage(named: "nav_btn_fanhuijiantou_normal")

        //用于消除左边空隙，要不然按钮顶不到最前面
//        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
//                                     action: nil)
//        spacer.width = -10

//        navigationBar.backIndicatorImage = UIImage(named: "nav_btn_fanhuijiantou_normal")
//        navigationItem.backBarButtonItem = leftBarBtn
    }
    
    func initDataSource() {
        // Oberride point
    }
    
    @objc func popViewController() {
        
    }
}
