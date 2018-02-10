//
//  ContactViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/29.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class ContactViewController: BaseViewController {
    let leftInfo = ["联系人一", "与本人关系", "姓名", "联系电话", "联系人二", "与本人关系", "姓名", "联系电话"]
    var detail = ["请选择", "请选择"]
    var relation = [TypeModel]()
    var fstNameTF: UITextField?
    var fstPhoneTF: UITextField?
    var fstRelation: TypeModel?
    var secondNameTF: UITextField?
    var secondPhoneTF: UITextField?
    var secondRelation: TypeModel?
    var authCallback: (()->())?
    
    override func initUserInterface() {
        super.initUserInterface()
        
        title = "联系人信息"
        
        let commitButton = UIButton.bottomButton(title: "提交")
        commitButton.addTarget(self, action: #selector(responsedToCommitButton), for: .touchUpInside)
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(50)
        }
        
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(commitButton.snp.top)
        }
        
    }
    
    override func initDataSource() {
        super.initDataSource()
        CertificationModel.checkList(typeNames: ["relation"]) { (data) in
            guard let relasion = data.relation else{return}
            self.relation = relasion
        }
    }
    
    @objc func responsedToCommitButton() {
        guard let fstName = fstNameTF?.text else{return}
        guard let fstPhone = fstPhoneTF?.text else{return}
        guard let secondName = secondNameTF?.text else{return}
        guard let secondPhone = secondPhoneTF?.text else{return}
        
        guard fstName.count > 0 else{return view.showHUD("请输入联系人一姓名")}
        guard fstPhone.count > 0 else{return view.showHUD("请输入联系人一电话")}
        guard let fstRel = fstRelation else{return view.showHUD("请选择联系人一关系")}
        guard secondName.count > 0 else{return view.showHUD("请输入联系人二姓名")}
        guard secondPhone.count > 0 else{return view.showHUD("请输入联系人二电话")}
        guard let secondRel = secondRelation else{return view.showHUD("请选择联系人二关系")}
        guard fstPhone.isMobile() else {
            return view.showHUD("联系人一手机号格式错误")
        }
        guard secondPhone.isMobile() else {
            return view.showHUD("联系人二手机号格式错误")
        }
        let fstContact = ContactData(name: fstName, rel: fstRel.valName, tel: fstPhone)
        let secondContact = ContactData(name: secondName, rel: secondRel.valName, tel: secondPhone)
        CertificationModel.saveContactInfo(contacts: [fstContact, secondContact]) {
            self.authCallback?()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.mm_reuseCell(indexPath) as ScanBankCardCell
        cell.commonLabel.text = leftInfo[indexPath.row]
        if indexPath.row.isIn(0, 4) {
            cell.type = .rightField
            cell.commonLabel.textColor = UIColor.theme
            cell.inputTextfield.placeholder = ""
            cell.inputTextfield.isEnabled = false
        } else if indexPath.row.isIn(2, 3, 6, 7) {
            cell.type = .cardNumber
            cell.scanButton.isHidden = true
            cell.cardNumberTextfield.placeholder = "请输入"
            cell.cardNumberTextfield.snp.remakeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(Scale.width(120))
                make.height.equalTo(44)
                make.width.equalTo(cell.contentView).multipliedBy(0.35)
            })
            switch indexPath.row {
            case 2: fstNameTF = cell.cardNumberTextfield
            case 3:
                fstPhoneTF = cell.cardNumberTextfield
                fstPhoneTF?.keyboardType = .phonePad
            case 6: secondNameTF = cell.cardNumberTextfield
            case 7:
                secondPhoneTF = cell.cardNumberTextfield
                secondPhoneTF?.keyboardType = .phonePad
            default:break
            }
            fstNameTF = cell.cardNumberTextfield
        } else {
            cell.detailLabel.text = detail[indexPath.row == 1 ? 0: 1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1, 5:
            CommonPickerView.show(dataSource: relation, callback: { type in
                self.detail[indexPath.row == 1 ? 0: 1] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
                if indexPath.row == 1 {
                    self.fstRelation = type
                } else {
                    self.secondRelation = type
                }
            })
        default:
            break
        }
    }
}
