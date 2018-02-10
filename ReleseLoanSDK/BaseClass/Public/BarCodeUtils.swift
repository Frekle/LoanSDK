//
//  QRCodeUtils.swift
//  HomerEU
//
//  Created by Mango on 16/6/28.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit


struct BarcodeCodeUtils {

    enum BarcodeType {
        case barcode
        case qrCode
        
        var filterName: String {
            switch self {
            case .barcode:
                return "CICode128BarcodeGenerator"
            case .qrCode:
                return "CIQRCodeGenerator"
            }
        }
    }
    
    static func generateBarcodeImage(_ data: Data?, width: CGFloat, type: BarcodeType) -> UIImage? {
        
        let resultWidth = CGFloat(ceilf(Float(width)))
        let filter = CIFilter(name: type.filterName)
        filter?.setValue(data, forKey: "inputMessage")
        switch type {
        case .barcode:
            break
        default:
            filter?.setValue("H", forKey: "inputCorrectionLevel")
        }
        if let outputImage = filter?.outputImage {
            let scaleX = resultWidth / outputImage.extent.size.width
            let scaleY = resultWidth / outputImage.extent.size.height
            let transformI = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            return UIImage(ciImage: transformI)
        }
        return nil
    }
    
    static func generateCode128BarcodeImage(_ data: Data?, width: CGFloat) -> UIImage? {
        return generateBarcodeImage(data, width: width, type: .barcode)
    }
    
    static func generateCode128BarcodeImage(_ text: String, width: CGFloat) -> UIImage? {
        return generateCode128BarcodeImage(text.data(using: String.Encoding.utf8), width: width)
    }
    
    static func generateQRCodeImage(_ data: Data?, width: CGFloat) -> UIImage? {
        return generateBarcodeImage(data, width: width, type: .qrCode)
    }
    
    static func generateQRCodeImage(_ text: String, width: CGFloat) -> UIImage? {
        return generateQRCodeImage(text.data(using: String.Encoding.utf8), width: width)
    }
}
