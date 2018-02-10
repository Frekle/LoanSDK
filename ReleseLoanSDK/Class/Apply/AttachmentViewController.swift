//
//  AttachmentViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/29.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class AttachmentViewController: BaseViewController {
    
    let photoPicker = UIImagePickerController()
    let tableView = BaseTableView()
    var isFront = true
    var frontImage: UIImage?
    var backImage: UIImage?
    var authCallback:(()->())?
    
    override func initUserInterface() {
        super.initUserInterface()
        title = "附件信息"
        
        
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
        
        photoPicker.delegate = self
        photoPicker.sourceType = .camera
    }
    
    override func initDataSource() {
        super.initDataSource()
        CertificationModel.checkList(typeNames: ["atta_type"]) { (type) in
            
        }
    }
    
    @objc func responsedToCommitButton() {
        if frontImage != nil && backImage != nil {
            authCallback?()
        }
    }
    
    func uploadImage(attType: String, oldAtt: String, image: UIImage?) {
        
        guard let image = image else { return }
        NetWorkManager.uploadImage(attType: attType, oldAtt: oldAtt, image: image) { (data) in
            
        }
    }
    
}

extension AttachmentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if isFront {
            frontImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        } else {
            backImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        tableView.reloadData()
        photoPicker.dismiss(animated: true) {
            // 正面 20800002 背面 20800003
            let attType = self.isFront ? "20800002": "20800003"
            let oldAtt = self.isFront ? "银行卡正面": "银行卡背面"
            self.uploadImage(attType: attType, oldAtt: oldAtt, image: info[UIImagePickerControllerOriginalImage] as? UIImage)
        }
    }
}

extension AttachmentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_reuseCell(indexPath) as ScanAttachmentCell
        if let frontImage = frontImage {
            cell.frontButton?.setImage(frontImage, for: .normal)
            cell.frontLabel?.text = "重新上传"
        }
        if let behindImage = backImage {
            cell.behindButton?.setImage(behindImage, for: .normal)
            cell.behindLabel?.text = "重新上传"
        }
        cell.frontCallBack = {
            self.isFront = true
            self.present(self.photoPicker, animated: true, completion: nil)
        }

        cell.backCallBack = {
            self.isFront = false
            self.present(self.photoPicker, animated: true, completion: nil)
        }
        return cell
    }

}


