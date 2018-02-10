//
//  MineViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/15.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    let imageList = [["icon_wodedingdan","icon_wodeyinhangka", "icon_zhanghuguanli"], ["icon_changjianwenti", "icon_yijianfankui", "icon_guanyuwomen"]]
    let itemList = [["我的订单","我的银行卡", "账户管理"], ["常见问题", "意见反馈", "关于我们"]]
    
    override func initUserInterface() {
        super.initUserInterface()
        
//        title = "注册任信用，最高领取5万额度"
        
        let tableView = BaseTableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = UIColor.view
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}

extension MineViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return tableView.mm_reuseCell(indexPath) as UserHeaderCell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as CertificationCell
            cell.sortImageView.image = UIImage(named: imageList[indexPath.section - 1][indexPath.row])
            cell.sortLabel.text = itemList[indexPath.section - 1][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return 140
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            break
//            let alertController = UIAlertController()
//            let action = UIAlertAction.init(title: "拍照", style: .default, handler: { (action) in
//
//            })
//            let picAction = UIAlertAction.init(title: "从手机相册选择", style: .default, handler: { (action) in
//
//            })
//            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
//
//            })
//            alertController.addAction(action)
//            alertController.addAction(picAction)
//            alertController.addAction(cancelAction)
//            present(alertController, animated: true, completion: nil)
        case (1, 0):
            let orderVC = AllOrderViewController()
            orderVC.type = .all
            self.navigationController?.pushViewController(orderVC, animated: true)
        case (1, 1):
            navigationController?.pushViewController(MineCardsViewController(), animated: true)
        case (1, 2):
            navigationController?.pushViewController(UserManagerViewController(), animated: true)
        case (2, 0):
            navigationController?.pushViewController(UsualQuestionsViewController(), animated: true)
        case (2, 1):
            navigationController?.pushViewController(AdviceViewController(), animated: true)
        case (2, 2):
            let webView = BaseWebViewController()
            webView.title = "关于我们"
            webView.urlString = "http://apk.boyacx.com/renxinyong/html/aboutUs.html"
            navigationController?.pushViewController(webView, animated: true)
        default:
            break
        }
    }
}
