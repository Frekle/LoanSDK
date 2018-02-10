//
//  DefaultOrderTableView.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/20.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class DefaultOrderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUserInterface() {
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}

extension DefaultOrderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_dequeueStaticCell(indexPath) as DefaultOrderCell
            return cell
        case 1:
            let cell = tableView.mm_dequeueStaticCell(indexPath) as CommonTextCell
            cell.commonLabel.text = "推荐贷款"
            cell.rightArrow.isHidden = true
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as OrderCommonCell
            return cell
        }
    }
}
