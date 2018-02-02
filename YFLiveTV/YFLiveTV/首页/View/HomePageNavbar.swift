//
//  HomePageNavbar.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/25.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit

class HomePageNavbar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
    }
    func setUI()  {
        let leftItemButton:UIButton = UIButton(type: .system)
        leftItemButton.setImage(UIImage.init(named: "shouye_icon_scan_white"), for: .normal)
        leftItemButton.addTarget(self, action: #selector(leftButtonItemClick), for: .touchUpInside)
        
    }
    @objc func leftButtonItemClick()  {
        
    }

}
