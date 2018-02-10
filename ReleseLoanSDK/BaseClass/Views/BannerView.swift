//
//  BannerView.swift
//  UTOO
//
//  Created by Frekle on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import UIKit
import SDWebImage

class BannerView: UIView {
    
    var imageItems = [String]() {
        didSet {
            updateData()
        }
    }
    var currentImage: UIImage? { get { return screen1.image } }
    var placeHolderImage = UIImage.init(named:"defualt_image")
    var showPageControl = true {
        didSet {
            pageControl.isHidden = !showPageControl
        }
    }
    var imageViewContentMode = UIViewContentMode.scaleAspectFill {
        didSet {
            screen0.contentMode = imageViewContentMode
            screen1.contentMode = imageViewContentMode
            screen2.contentMode = imageViewContentMode
            
            screen0.layer.masksToBounds = true
            screen1.layer.masksToBounds = true
            screen2.layer.masksToBounds = true
        }
    }
    var eventHandler: ((UIImageView, Int) -> Void)?
    
    fileprivate var screen0 = UIImageView()
    fileprivate var screen1 = UIImageView()
    fileprivate var screen2 = UIImageView()
    fileprivate var currentPage = 0
    fileprivate let scrollView = UIScrollView()
    fileprivate let pageControl = UIPageControl()
    
    let AUTOPLAYINTERVAL = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUserInterface()
        updateData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUserInterface() {
        backgroundColor = UIColor.clear
        
        scrollView.frame = frame
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        scrollView.contentSize = CGSize(width: frame.size.width * 3, height: frame.size.height)
        scrollView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        scrollView.contentOffset = CGPoint(x: frame.size.width, y: 0) // 显示第二页
        addSubview(scrollView)
        
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.red
        addSubview(pageControl)
        
        screen0.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        screen0.tag = 0
        screen0.isUserInteractionEnabled = true
        scrollView.addSubview(screen0)
        
        screen1.frame = CGRect(x: bounds.size.width, y: 0, width: bounds.size.width, height: bounds.size.height)
        screen1.tag = 0
        screen1.isUserInteractionEnabled = true
        scrollView.addSubview(screen1)
        
        screen2.frame = CGRect(x: bounds.size.width * 2, y: 0, width: bounds.size.width, height: bounds.size.height)
        screen2.tag = 0
        screen2.isUserInteractionEnabled = true
        scrollView.addSubview(screen2)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureRecognizerForDatailClick))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    @objc func singleTapGestureRecognizerForDatailClick() {
        if currentPage > -1 && currentPage < self.imageItems.count {
            eventHandler?(screen1, currentPage)
        }
    }
    
    func updateData() {
        let pageControlWidth: CGFloat = CGFloat(imageItems.count) * 10 + 40
        let pageControlHeight: CGFloat = 20
        pageControl.frame = CGRect(x: (frame.size.width - pageControlWidth)/2, y: frame.size.height - 20, width: pageControlWidth, height: pageControlHeight)
        pageControl.numberOfPages = imageItems.count
        pageControl.currentPage = 0
        currentPage = 0
        update3Screens()
        
        // 显示第二屏数据
        scrollView.setContentOffset(CGPoint.init(x: scrollView.frame.size.width, y: 0), animated: false)
        if imageItems.count <= 1  {
            scrollView.isUserInteractionEnabled = false
            pageControl.isHidden = true
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(switchToNextPage), object: nil)
        } else {
            scrollView.isUserInteractionEnabled = true
            pageControl.isHidden = !showPageControl
            perform(#selector(switchToNextPage), with: nil, afterDelay: TimeInterval(AUTOPLAYINTERVAL))
        }
    }
    
    @objc func switchToNextPage() {
        if scrollView.isDragging == true {
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(switchToNextPage), object: nil)
        
        scrollView.setContentOffset(CGPoint.init(x: scrollView.frame.size.width*2, y: 0), animated: true)
        currentPage += 1
        if currentPage >= imageItems.count {
            currentPage = 0
        }
        perform(#selector(switchToNextPage), with: nil, afterDelay: TimeInterval(AUTOPLAYINTERVAL))
    }
    
    func update3Screens() {
        if imageItems.count == 0 {
            screen0.image = nil
            screen1.image = placeHolderImage
            screen2.image = nil
            return
        }
        updateScreen0()
        updateScreen1()
        updateScreen2()
    }
    
    func updateScreen0() {
        var info: String = ""
        if currentPage == 0 {
            info = imageItems[imageItems.count - 1]
        } else {
            info = imageItems[currentPage - 1]
        }
        updateScreen(screen: screen0, imageName: info)
    }
    
    func updateScreen1() {
        let info = imageItems[currentPage]
        updateScreen(screen: screen1, imageName: info)
    }
    
    func updateScreen2() {
        var info = ""
        if currentPage == imageItems.count - 1 {
            info = imageItems[0]
        } else {
            info = imageItems[currentPage+1]
        }
        updateScreen(screen: screen2, imageName: info)
    }
    
    func updateScreen(screen: UIImageView, imageName: String) {
        if imageName.hasPrefix("http://") || imageName.hasPrefix("http://") {
            screen.sd_setImage(with: URL(string: imageName), placeholderImage: placeHolderImage)
        } else {
            screen.image = UIImage(named: imageName)
        }
    }
}

extension BannerView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(switchToNextPage), object: nil)
        self.perform(#selector(switchToNextPage), with: nil, afterDelay: TimeInterval(AUTOPLAYINTERVAL))
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        update3Screens()
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width, y: 0), animated: false)
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.imageItems.count != 0 {
            if(scrollView.contentOffset.x < scrollView.bounds.size.width/2) {  // 在第一屏
                currentPage -= 1
                if(currentPage < 0) {
                    currentPage = self.imageItems.count-1
                }
            }
            else if(scrollView.contentOffset.x > scrollView.bounds.size.width*1.5){   // 在第三屏
                currentPage += 1
                if(currentPage >= self.imageItems.count){
                    currentPage = 0
                }
            }
            update3Screens()
            // 无动画滚回第二屏
            scrollView.setContentOffset(CGPoint.init(x: scrollView.frame.size.width, y: 0), animated: false)
            pageControl.currentPage = currentPage
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 只有在拖动时，才会实时调整 _pageControl.currentPage
        if(scrollView.isDragging == false) {
            return
        }
        
        // 实时调整 _pageControl.currentPage
        var page = 1
        if(scrollView.contentOffset.x < scrollView.bounds.size.width/2){  // 在第一屏
            page = 0;
        }
        else if(scrollView.contentOffset.x > scrollView.bounds.size.width*1.5){   // 在第三屏
            page = 2;
        }
        
        page = currentPage + page - 1  // _pageControl 应该设置成的当前页数
        if(page < 0){
            page = self.imageItems.count-1
        }
        else if(page >= self.imageItems.count){
            page = 0
        }
        pageControl.currentPage = page
    }
}

//extension BannerView: UIGestureRecognizerDelegate {
//    
//}
