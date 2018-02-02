//
//  UIDeviceextension.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/25.
//  Copyright © 2018年 guopenglai. All rights reserved.
//
//是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
import Foundation
import UIKit
extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
