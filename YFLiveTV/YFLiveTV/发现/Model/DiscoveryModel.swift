//
//  DiscoveryModel.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/2/2.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit

class DiscoveryModel: NSObject {

    var roomid : Int?
    var name : String?
    var pic51 : String?
    var pic74 : String?
    var live : Int?  // 是否在直播
    var push : Int?  // 直播显示方式
    var focus : Int? // 关注数
    
    var uid : String?
    
    var isEvenIndex : Bool?
}
