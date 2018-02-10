//
//  CertificationViewController.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/14.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class CertificationViewController: BaseViewController {

    let imageList = ["icon_shenfenzhengshibie", "icon_renlianshibie", "icon_xueli", "icon_zhiye", "icon_qq", "icon_hunyinzhuangkuang", "icon_jiatingzhuzhi"]
    let itemList = ["身份证识别", "人脸识别", "学历", "职业", "QQ", "婚姻状况", "家庭住址"]
    var detailsList = ["去识别", "去识别", "请选择", "请选择", "请输入", "未婚", "请选择"]
    
    var faceIdResultData: FaceIdResultData?
    var idCardInfo: IDCardInfoData?
    
    let tableView = BaseTableView()
    
    var educations = [TypeModel]()
    var workJobs = [TypeModel]()
    var marriageStatus = [TypeModel]()
    var sex = [TypeModel]()
    var nations = [TypeModel]()
    var marriage = ""
    var province = ""
    var city = ""
    var area = ""
    var addressTextfield: UITextField?
    var qqTextfield: UITextField?
    
    var selectedEducation = TypeModel()
    var selectedWork = TypeModel()
    var selectedMarriage = TypeModel()
    var selectedSex = TypeModel()
    var selectedNation = TypeModel()
    
    override func initUserInterface() {
        
        title = "申请人资质"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let nextStepButton = UIButton.bottomButton(title: "下一步")
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        view.addSubview(nextStepButton)
        nextStepButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    override func initDataSource() {
        CertificationModel.checkList(typeNames: ["education", "work_job", "marriage_status", "sex", "nation"]) { (data) in
            
            guard let education = data.education else {return}
            self.educations = education
            guard let workJob = data.work_job else {return}
            self.workJobs = workJob
            guard let marriage = data.marriage_status else{ return }
            self.marriageStatus = marriage
            guard let sex = data.sex else{ return }
            self.sex = sex
            guard let nation = data.nation else {return}
            self.nations = nation
            self.view.hidAllHud()
        }
    }
    
    @objc func nextStep() {
//        ["liveProv": "河北省", "regProv": "", "regArea": "", "certOrg": "成都市公安局成华区分局", "regAddr": "", "ethnic": "汉", "certNo": "510623199301268616", "regCity": "", "liveAddr": "你自以为", "edu": "61000001", "certValidDate": "2012.02.06-2022.02.06", "liveArea": "桥西区", "custName": "王振宇", "qq": "501957105", "phoneNo": "13688406440", "marriage": "未婚", "workJob": "20700001", "liveCity": "石家庄市", "sex": "男"]
        
        
        
//        CertificationModel.saveUserInfoStep1(phone: UserInfo.shared().user?.loginNo ?? "", custName: "王振宇", sex: "男", workJob: "农民", ethnic: "汉", marriage: "已婚", certNo: "510623199301268616", certOrg: "成都市公安局成华区分局", certValidDate: "2022-02-06", regProv: "", regCity: "", regArea: "", regAddr: "", liveProv: "河北省", liveCity: "石家庄市", liveArea: "桥西区", liveAddr: "不知道哦", qq: "123456789", edu: "本科", callback: { string in
//            if string == "0000" {
//                let borrowVC = BorrowAmountViewController()
//                let data = FaceIdResultData()
//                let idcard = IDCardInfoData()
//                idcard.idcardName = "王振宇"
//                idcard.idcardNumber = "510623199301268616"
//                if let user = UserInfo.shared().user {
//                    user.idCardNumber = idcard.idcardNumber
//                    user.userName = idcard.idcardName
//                    UserInfo.shared().setLoginedUserCached(user)
//                }
//                let result = FaceIDVerifyResult()
//                result.result_faceid.confidence = 89
//                data.verifyResult = result
//                data.idCardInfo = idcard
//                borrowVC.faceIdResultData = data
//                self.navigationController?.pushViewController(borrowVC, animated: true)
//            }
//        })
        
        
        guard let idCardInfo = idCardInfo else { return view.showHUD("请进行身份证识别")}
        guard let address = addressTextfield?.text else {return}
        guard let qq = qqTextfield?.text else {return}
        guard address != "" else {
            return view.showHUD("请输入详细地址")
        }
        guard qq != "" else {
            return view.showHUD("请输入qq号码")
        }
        var valiDate = idCardInfo.validDate
        let arr = valiDate.components(separatedBy: "-")
        if arr.count > 1 {
            valiDate = arr[1]
            valiDate = valiDate.replacingOccurrences(of: ".", with: "-")
        }

        // 户口省市区
        CertificationModel.saveUserInfoStep1(phone: UserInfo.shared().user?.loginNo ?? "", custName: idCardInfo.idcardName, sex: idCardInfo.gender, workJob: selectedWork.valName, ethnic: idCardInfo.race, marriage: marriage, certNo: idCardInfo.idcardNumber, certOrg: idCardInfo.issuedBy, certValidDate: valiDate, regProv: "", regCity: "", regArea: "", regAddr: "", liveProv: province, liveCity: city, liveArea: area, liveAddr: address, qq: qq, edu: selectedEducation.valName, callback: { string in
            if string == "0000" {
                let borrowVC = BorrowAmountViewController()
                borrowVC.faceIdResultData = self.faceIdResultData
                self.navigationController?.pushViewController(borrowVC, animated: true)
            }
        })
    }
}

extension CertificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.mm_reuseCell(indexPath) as ApplyStepsCell
        case imageList.count + 1:
            let cell = tableView.mm_reuseCell(indexPath) as AddressTextfieldCell
            self.addressTextfield = cell.textfield
            return cell
        default:
            let certificationCell = tableView.mm_reuseCell(indexPath) as CertificationCell
            certificationCell.sortImageView.image = UIImage(named: imageList[indexPath.row - 1])
            certificationCell.sortLabel.text = itemList[indexPath.row - 1]
            certificationCell.detailLabel.text = detailsList[indexPath.row - 1]
            
            if indexPath.row.isIn(5) {
                certificationCell.couldPush = false
                certificationCell.inputTextfield.isHidden = false
                certificationCell.inputTextfield.keyboardType = .numberPad
                self.qqTextfield = certificationCell.inputTextfield
            } else if indexPath.row.isIn(6) {
                certificationCell.couldPush = false
                certificationCell.marrySwitch.isHidden = false
                certificationCell.selectedMarriageItem = { marriage in
                    self.marriage = marriage
                }
            } 
            
            return certificationCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let idcardVC = IDCardIdentifyViewController()
            idcardVC.commitCallback = { data in
                self.detailsList[0] = "已认证"
                self.detailsList[1] = "已认证"
                tableView.reloadData()
                self.faceIdResultData = data
                self.idCardInfo = data?.idCardInfo
            }
            navigationController?.pushViewController(idcardVC, animated: true)
        case 2:
            if detailsList[1] == "已认证" {
                view.showHUD("请选择身份证识别")
            }
            view.showHUD("请先进行身份证识别")
        case 3:
            guard educations.count > 0 else{ return }
            CommonPickerView.show(dataSource: educations, callback: { (type) in
                self.selectedEducation = type
                self.detailsList[indexPath.row - 1] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        case 4:
            guard workJobs.count > 0 else{ return }
            CommonPickerView.show(dataSource: workJobs, callback: { (type) in
                self.selectedWork = type
                self.detailsList[indexPath.row - 1] = type.valName
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        case 7:
            CityPickerView().show(didTapSureButton: { province, city, area in
                self.province = province
                self.city = city
                self.area = area
                self.detailsList[indexPath.row - 1] = province + "" + city + "" + area
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        default:
            break
        }
    }
}
