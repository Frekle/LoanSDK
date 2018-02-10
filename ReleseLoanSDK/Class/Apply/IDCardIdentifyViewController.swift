//
//  IDCardIdentifyViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/17.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class IDCardIdentifyViewController: BaseViewController {

    let leftTitle = ["姓名", "身份证"]
    var details = ["请先扫描身份证", "请先扫描身份证"]
    var frontImage: UIImage?
    var behindImage: UIImage?
    var data: FaceIdResultData? {
        didSet {
            details[0] = data?.idCardInfo.idcardName ?? ""
            details[1] = data?.idCardInfo.idcardNumber ?? ""
        }
    }
    var commitCallback: ((FaceIdResultData?)->())?
    
    override func initUserInterface() {
        super.initUserInterface()
        title = "身份证识别"
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let commitButton = UIButton.bottomButton(title: "提交")
        commitButton.addTarget(self, action: #selector(responsedToCommitButton), for: .touchUpInside)
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    @objc func responsedToCommitButton() {
        guard let data = data else{return view.showHUD("请先认证")}
        let idcard = data.idCardInfo.idcardNumber
        let name = data.idCardInfo.idcardName
        if let user = UserInfo.shared().user {
            user.userName = idcard
            user.idCardNumber = name
            UserInfo.shared().setLoginedUserCached(user)
        }
        self.commitCallback?(data)
        self.navigationController?.popViewController(animated: true)
    }

    func dataURlToImage(imageSrc: String) -> UIImage? {
        if let url = URL(string: imageSrc) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    return image
                }
            }
        }
        return nil
    }
}

extension IDCardIdentifyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.mm_reuseCell(indexPath) as ScanningIDCardCell
            if let frontImg = frontImage {
                cell.frontButton?.setImage(frontImg, for: .normal)
            }
            if let behindImg = behindImage {
                cell.behindButton?.setImage(behindImg, for: .normal)
            }
            return cell
        case 1:
            let cell = tableView.mm_reuseCell(indexPath) as CommonTextCell
            cell.commonLabel.text = "请确认身份信息"
            cell.commonLabel.font = UIFont.size18
            cell.rightArrow.isHidden = true
            return cell
        default:
            let cell = tableView.mm_reuseCell(indexPath) as OurInfoCell
            cell.mainLabel.text = leftTitle[indexPath.row - 2]
            cell.mainLabel.snp.remakeConstraints { (make) in
                make.centerY.equalTo(cell.contentView)
                make.left.equalTo(cell.contentView).offset(40)
            }
            cell.detailLabel.text = details[indexPath.row - 2]
            cell.detailLabel.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(cell.contentView)
                make.right.equalTo(cell.contentView).offset(-20)
            })
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let faceIDVC = FaceIdWebViewController()
            faceIDVC.successCallback = { result in
                self.frontImage = self.dataURlToImage(imageSrc: result.images.frontImage)
                self.behindImage = self.dataURlToImage(imageSrc: result.images.backImage)
                self.data = result
                tableView.reloadData()
            }
            self.navigationController?.pushViewController(faceIDVC, animated: true)
        default:
            break
        }
    }
}

