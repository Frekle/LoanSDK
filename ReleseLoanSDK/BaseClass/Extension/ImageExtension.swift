//
//  ImageExtension.swift
//  UTOO
//
//  Created by Frekle on 2017/3/9.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIImage {
    //  根据图片的中心点去拉伸图片并返回
    func resizableImageWithCenterPoint() -> UIImage {
        let top = self.size.height * 0.5 - 1
        let bottom = top
        let left = self.size.width * 0.5 - 1
        let right = left
        let insets = UIEdgeInsetsMake(top, left, bottom, right)
        let image = self.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        return image
    }
    
    open class var defualtImage: UIImage? { get { return UIImage(named: "defualt_image") } }
    open class var storeBgImage: UIImage? { get { return UIImage(named: "store_header_bg") } }
    
    static func imageWithColor(_ color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImageView {
    
    convenience init(name: String) {
        self.init()
        image = UIImage(named: name)
    }
}
