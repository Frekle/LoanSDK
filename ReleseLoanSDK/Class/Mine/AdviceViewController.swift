//
//  AdviceViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class AdviceViewController: BaseViewController {

    override func initUserInterface() {
        super.initUserInterface()
        title = "意见反馈"
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

}

extension AdviceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_reuseCell(indexPath) as AdviceCell
        cell.commitCallback = {
            Window?.showHUD("提交成功")
            self.navigationController?.popViewController(animated: true)
        }
        return cell
    }
}
