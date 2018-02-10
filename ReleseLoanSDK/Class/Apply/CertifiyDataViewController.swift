//
//  CertifiyDataViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CertifiyDataViewController: BaseViewController {

    let imageList = ["icon_chuxuka", "icon_wangyinrenzheng", "icon_zhimaxinyong", "icon_dianshang", "icon_shouji", "icon_gongsixinxi", "icon_lianxirenxinxi", "icon_qitaxinxi"]
    let itemList = ["*储蓄卡绑定", "*网银认证", "*芝麻信用认证", "*手机运营商认证", "电商认证", "*公司信息", "*联系人信息", "*附件信息"]
    var detailsList = ["去绑定", "去认证", "去认证", "去认证", "去认证", "去认证", "去认证", "去认证"]
    
    let tableView = BaseTableView()
    
    var faceIdResultData: FaceIdResultData?
    
    override func initUserInterface() {
        
        title = "认证资料"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let nextStepButton = UIButton.bottomButton(title: "下一步")
        nextStepButton.addTarget(self, action: #selector(CertifiyDataViewController.nextStep), for: .touchUpInside)
        view.addSubview(nextStepButton)
        nextStepButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    @objc func nextStep() {
        guard let data = faceIdResultData else{return view.showHUD("请先认证")}
        let idcard = data.idCardInfo.idcardNumber
        let name = data.idCardInfo.idcardName
        let similary = data.verifyResult.result_faceid.confidence
        CertificationModel.saveFaceSimilary(idcard: idcard, name: name, score: "\(similary)") { (data) in
            if data {
                self.apply()
            }
        }
    }
    
    func apply() {
        CertificationModel.submitApply { (result) in
            if result == "0000" {
                self.navigationController?.pushViewController(ApplySuccessViewController(), animated: true)
            }
        }
    }
}

extension CertifiyDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_reuseCell(indexPath) as ApplyStepsCell
            cell.stepsImageView.image = UIImage.init(named: "pic_buzhou3")
            return cell
        default:
            let certificationCell = tableView.mm_reuseCell(indexPath) as CertificationCell
            certificationCell.sortImageView.image = UIImage(named: imageList[indexPath.row - 1])
            certificationCell.sortLabel.text = itemList[indexPath.row - 1]
            certificationCell.detailLabel.text = detailsList[indexPath.row - 1]
            return certificationCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let vc = CashCardViewController()
            vc.title = "储蓄卡绑定"
            vc.authCallback = {
                self.detailsList[indexPath.row - 1] = "已绑定"
            }
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let webView = BaseWebViewController()
            webView.title = "网银认证"
            webView.urlString = Api.authOnlineBank.fullPath + Api.authOnlineBank.parameters.parsingParams()
            webView.authCallback = {
                self.detailsList[indexPath.row - 1] = "已认证"
            }
            navigationController?.pushViewController(webView, animated: true)
        case 3:
            view.showLoading()
            CertificationModel.getZhiMaUrl { (data) in
                self.view.hidAllHud()
                let webVC = BaseWebViewController()
                webVC.title = "芝麻信用认证"
                webVC.urlString = data
                webVC.authCallback = {
                    self.detailsList[indexPath.row - 1] = "已认证"
                }
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        case 4:
            navigationController?.pushViewController(MobileOperatorViewController(), animated: true)
        case 5:
            let ecVC = ECommerceViewController()
            ecVC.authCallback = {
                self.detailsList[indexPath.row - 1] = "已认证"
            }
            navigationController?.pushViewController(ecVC, animated: true)
        case 6:
            let companyVC = CompanyInfoViewController()
            companyVC.commitCallback = { success in
                self.detailsList[indexPath.row - 1] = "已认证"
            }
            navigationController?.pushViewController(companyVC, animated: true)
        case 7:
            let contactVC = ContactViewController()
            contactVC.authCallback = {
                self.detailsList[indexPath.row - 1] = "已认证"
            }
            navigationController?.pushViewController(ContactViewController(), animated: true)
        case 8:
            let contactVC = AttachmentViewController()
            contactVC.authCallback = {
                self.detailsList[indexPath.row - 1] = "已认证"
            }
            navigationController?.pushViewController(contactVC, animated: true)
        default:
            break
        }
    }
}
