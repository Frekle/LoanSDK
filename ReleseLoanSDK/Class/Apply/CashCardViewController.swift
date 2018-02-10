//
//  CashCardViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/17.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CashCardViewController: BaseViewController {

    let leftTitle = ["卡号", "开户行", "姓名", "开卡地区", "开户支行"]
    var details = ["请选择", "请选择"]
    
    let photoPicker = UIImagePickerController()
    let tableView = BaseTableView()
    
    var open_org = [TypeModel]()
    
    
    var nameField: UITextField?
    var bankField: UITextField?
    var bankNoField: UITextField?
    var selectedOpenOrg: TypeModel?
    var selectedProv: String?
    var selectedCity: String?
    var bankType = "42800001"
    var authCallback: (()->())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        
        
        
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
        if title == "储蓄卡绑定" {
            commitButton.snp.makeConstraints { (make) in
                make.bottom.left.right.equalTo(view)
                make.height.equalTo(50)
            }
        } else {
            commitButton.layer.cornerRadius = 25
            commitButton.clipsToBounds = true
            commitButton.setTitle("保存", for: .normal)
            commitButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(view).offset(-Scale.height(250))
                make.left.equalTo(view).offset(20)
                make.right.equalTo(view).offset(-20)
                make.height.equalTo(50)
            }
        }
        
        photoPicker.delegate = self
        photoPicker.sourceType = .camera
    }
    
    override func initDataSource() {
        super.initDataSource()
        
        CertificationModel.checkList(typeNames: ["open_org"]) { (data) in
            guard let openOrg = data.open_org else{return}
            self.open_org = openOrg
        }
    }
    
    @objc func responsedToCommitButton() {
        guard let name = nameField?.text else {return}
        guard name != "" else {return view.showHUD("请输入姓名")}
        guard let cardNumber = bankNoField?.text else {return}
        guard cardNumber != "" else {return view.showHUD("请输入卡号")}
        guard let addr = bankField?.text else {return}
        guard addr != "" else {return view.showHUD("请输入开户支行")}
        var openOrg = details[0]
        if openOrg == "请选择" {
            guard let selectedOpenOrg = selectedOpenOrg else{return view.showHUD("请选择开户行")}
            openOrg = selectedOpenOrg.valName
        }
        guard let selectedProv = selectedProv else{return view.showHUD("请选择开户地区")}
        guard let selectedCity = selectedCity else{return view.showHUD("请选择开户地区")}
        
        CertificationModel.verifyBankCard(bankCard: cardNumber.replacingOccurrences(of: " ", with: ""), name: name) { (data) in
            if data.is_matched {
                CertificationModel.saveBankCard(account: name, acctName: cardNumber.replacingOccurrences(of: " ", with: ""), openOrg: openOrg, openProv: selectedProv, openCity: selectedCity, openAddr: addr, bankType: "42800001") { (data) in
                    if data.resultString == "0000" {
                        self.authCallback?()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                self.view.showHUD("银行卡校验未通过")
            }
        }
    }
    
    func uploadImage(image: UIImage?) {
        guard let image = image else { return }
        FaceIdNetwork.uploadImageToFaceId(image: image) { (data) in
//            guard let result = data.result else { return }
            switch data.result {
            case 1001:
                self.bankNoField?.text = data.number
                if data.name != "null" {
                    self.nameField?.text = data.name
                }
                self.details[0] = data.bank
                self.tableView.reloadData()
            case 1002:
                break
            case 2001:
                self.view.showHUD("图片格式不支持")
            case 2002:
                self.view.showHUD("图片中未检测到银行卡")
            default:
                break
            }
        }
    }
    
    func takePickure() {
        present(self.photoPicker, animated: true, completion: nil)
    }
}

extension CashCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_dequeueStaticCell(indexPath) as ScanBankCardCell
        cell.commonLabel.text = leftTitle[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.type = .cardNumber
            bankNoField = cell.cardNumberTextfield
            cell.scanButtonClickedCallback = {
                self.takePickure()
            }
        case 1, 3:
            cell.type = .rightText
            cell.detailLabel.text = details[indexPath.row == 1 ? 0: 1]
        case 2:
            cell.type = .rightField
            nameField = cell.inputTextfield
        case 4:
            cell.type = .rightField
            bankField = cell.inputTextfield
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            CommonPickerView.show(dataSource: open_org, callback: { (type) in
                self.details[0] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
                self.selectedOpenOrg = type
            })
        case 3:
            CityPickerView().show(didTapSureButton: { (prov, city, zone) in
                self.details[1] = prov + "" + city + "" + zone
                tableView.reloadRows(at: [indexPath], with: .automatic)
                self.selectedProv = prov
                self.selectedCity = city
            })
        default:
            break
        }
    }
}

extension CashCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        photoPicker.dismiss(animated: true) {
            self.uploadImage(image: info[UIImagePickerControllerOriginalImage] as? UIImage)
        }
    }
}
