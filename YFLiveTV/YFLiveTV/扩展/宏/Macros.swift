//
//  Macros.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/24.
//  Copyright © 2018年 guopenglai. All rights reserved.
//
/******************    swift下没有宏定义，但是可以声明let常量，起到宏定义的功能         *************/
import Foundation
import UIKit
/******************    TabBar          *************/
let MallClassKey = "rootVCClassString"
let MallTitleKey = "title"
let MallImgKey  =  "imageName"
let MallSelImgKey = "selectedImageName"

//适配iPhone X
//灵活得到导航栏+状态栏的高度
let YFStatusBarAndNavigationBarHeight = (UIDevice.current.isX() ? 88 : 64)
//状态栏高度
let YFStatusBarHeight = (UIDevice.current.isX() ? 44 : 20)

let ScreenW:Int = Int(UIScreen.main.bounds.size.width)

let ScreenH:Int = Int(UIScreen.main.bounds.size.height)

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

let YFColorBase = UIColor.init(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)

