//
//  SigningViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/21.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class SigningViewController: BaseViewController {

    override func initUserInterface() {
        super.initUserInterface()
        title = "签约"
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(finished))
        
        
    }

    @objc func finished() {
        
    }
}
