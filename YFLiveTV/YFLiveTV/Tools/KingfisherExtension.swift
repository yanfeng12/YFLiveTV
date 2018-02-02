//
//  KingfisherExtension.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/25.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImage(_ URLString : String?, _ placeHolderName : String?) {
        
        guard let URLString = URLString else { return }
        
        guard let placeHolderName = placeHolderName else { return }
        
        guard let url = URL(string: URLString) else { return }
        
        kf.setImage(with: url, placeholder: UIImage.init(named: placeHolderName))
    }
}
