//
//  FaceIdData.swift
//  CapriceLoanSDK
//
//  Created by Frekle on 2018/1/24.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit
import ObjectMapper
class FaceIdTokenData: BaseData {

    var expiredTime = 0
    var token = ""
    var bizId = ""
    var requestId = ""
    var timeUsed = 0
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        expiredTime <- map["expired_time"]
        token <- map["token"]
        bizId <- map["biz_id"]
        requestId <- map["request_id"]
        timeUsed <- map["time_used"]
        
    }
}

enum FaceIdResultStatus: String {
    case notStarted = "NOT_STARTED"
    case cancelled = "CANCELLED"
    case ok = "OK"
}

class FaceIdResultData: BaseData {
    
//    var idcardUneditableField = ""
//    var idcardIssuedBy = ""
//    var idcardValidDate = ""
//    var idcardMode = ""
//    var idcardName = ""
//    var idcardNumber = ""
    var images = FaceIDImageData()
    var procedureType = ""
    var result = ""
    var VIDEOFaceInconsistent = 0
    var NOAudio = 0
    var FACENotFound = 0
    var NOTSynchronized = 0
    var VIDEOFormatUnsupported = 0
    var INVALIDVideoDuration = 0
    var LOWFaceQuality = 0
    var SRError = 0
    var UPLOADTimes = 0
    var requestId = ""
    var bizExtraData = ""
    var bizNo = ""
    var bizId = ""
    var timeUsed = 0
    
    var status = ""
    var idCardInfo = IDCardInfoData()
    var verifyResult = FaceIDVerifyResult()
    
    var resultStatus: FaceIdResultStatus {
        get {
            guard let resultStatus = FaceIdResultStatus(rawValue: status) else {return FaceIdResultStatus.cancelled}
            return resultStatus
        }
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)

        images <- map["images"]
        procedureType <- map["liveness_result.procedure_type"]
        result <- map["liveness_result.result"]
        VIDEOFaceInconsistent <- map["liveness_result.details.VIDEO_FACE_INCONSISTENT"]
        NOAudio <- map["liveness_result.details.NO_AUDIO"]
        FACENotFound <- map["liveness_result.details.FACE_NOT_FOUND"]
        NOTSynchronized <- map["liveness_result.details.NOT_SYNCHRONIZED"]
        VIDEOFormatUnsupported <- map["liveness_result.details.VIDEO_FORMAT_UNSUPPORTED"]
        INVALIDVideoDuration <- map["liveness_result.details.INVALID_VIDEO_DURATION"]
        LOWFaceQuality <- map["liveness_result.details.LOW_FACE_QUALITY"]
        SRError <- map["liveness_result.details.SR_ERROR"]
        UPLOADTimes <- map["liveness_result.details.UPLOAD_TIMES"]
        requestId <- map["request_id"]
        bizExtraData <- map["biz_info.biz_extra_data"]
        bizNo <- map["biz_info.biz_no"]
        bizId <- map["biz_info.biz_id"]
        timeUsed <- map["time_used"]
        status <- map["status"]
        idCardInfo <- map["idcard_info"]
        verifyResult <- map["verify_result"]
    }
}

class FaceIDImageData: BaseData {
    var frontImage = ""
    var backImage = ""
    var bestImage = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        frontImage <- map["image_idcard_front"]
        backImage <- map["image_idcard_back"]
        bestImage <- map["image_best"]
    }
}

class IDCardInfoData: BaseData {
    var idcardUneditableField = ""
    var idcardValidDate = ""
    var idcardNumber = ""
    var idcardIssuedBy = ""
    var idcardName = ""
    var idcardMode = ""
    var validDate = ""
    var issuedBy = ""
    var race = ""
    var month = ""
    var day = ""
    var year = ""
    var gender = ""
    var address = ""
//    var idCardNumber = ""
    var name = ""
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        idcardUneditableField <- map["idcard_uneditable_field"]
        idcardValidDate <- map["idcard_valid_date"]
        idcardNumber <- map["idcard_number"]
        idcardIssuedBy <- map["idcard_issued_by"]
        idcardName <- map["idcard_name"]
        idcardMode <- map["idcard_mode"]
        validDate <- map["back_side.ocr_result.valid_date"]
        issuedBy <- map["back_side.ocr_result.issued_by"]
        race <- map["front_side.ocr_result.race"]
        month <- map["front_side.ocr_result.birthday.month"]
        day <- map["front_side.ocr_result.birthday.day"]
        year <- map["front_side.ocr_result.birthday.year"]
        gender <- map["front_side.ocr_result.gender"]
        address <- map["front_side.ocr_result.address"]
//        idCardNumber <- map["front_side.ocr_result.id_card_number"]
        name <- map["front_side.ocr_result.name"]
        
    }
}

class FaceIDVerifyResult: BaseData {
    var result_idcard_datasource = FaceIDSimilaryData()
    var result_idcard_photo = FaceIDSimilaryData()
    var result_faceid = FaceIDSimilaryData()
    override func mapping(map: Map) {
        super.mapping(map: map)
        result_idcard_datasource <- map["result_idcard_datasource"]
        result_idcard_photo <- map["result_idcard_photo"]
        result_faceid <- map["result_faceid"]
    }
}

class FaceIDSimilaryData: BaseData {
    var confidence = 0
    override func mapping(map: Map) {
        super.mapping(map: map)
        confidence <- map["confidence"]
    }
}
