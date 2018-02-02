//
//  DiscoveryNavbar.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/25.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit
import SnapKit

class DiscoveryNavbar: UIView {

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
        setUI()
    }
    let leftItemButton:UIButton = UIButton(type: .system)
    let rightItemButton:UIButton = UIButton(type: .system)
    let rightRItemButton:UIButton = UIButton(type: .system)
    let topSearchView:UIView = UIView()
    let searchButton:UIButton = UIButton(type: .system)
    let voiceButton:UIButton = UIButton(type: .system)
    

    /*
     OC:
     dispatch_queue_t concurrentQuene = dispatch_queue_create("concurrentQuene", DISPATCH_QUEUE_CONCURRENT);
     
     dispatch_block_t block = dispatch_block_create(0, ^{
     NSLog(@"normal do some thing...");
     });
     dispatch_async(concurrentQuene, block);
     
     //
     dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_DEFAULT, 0, ^{
     NSLog(@"qos do some thing...");
     });
     dispatch_async(concurrentQuene, qosBlock);

     swift:
     let concurrentQueue = DispatchQueue.init(label: "concurrentQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil);
     
     let block = DispatchWorkItem.init(block: {
     print("normal do some thing...")
     })
     concurrentQueue.async(execute: block);
     
     let qosBlock = DispatchWorkItem.init(qos: .default, flags: .noQoS, block: {
     print("qos do some thing...")
     })

     */
        /*********** swift不能再声明dispatch_block_t了  **************/
    let concurrentQueue = DispatchQueue.init(label: "concurrentQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil);
    
    var leftItemClickBlock:DispatchWorkItem = DispatchWorkItem{
        
    }
    var rightItemClickBlock:DispatchWorkItem = DispatchWorkItem{
        
    }
    var rightRItemClickBlock:DispatchWorkItem = DispatchWorkItem{
        
    }
    var searchButtonClickBlock:DispatchWorkItem = DispatchWorkItem{
        
    }
    var voiceButtonClickBlock:DispatchWorkItem = DispatchWorkItem{
        
    }
    
    
    
    func setUI()  {
        //默认情况下按钮会被渲染成单一颜色
        //保留图标原来的颜色
//        let leftItemButtonImage = UIImage(named:"shouye_icon_scan_white")?.withRenderingMode(.alwaysOriginal)
//        leftItemButton.setImage(leftItemButtonImage, for: .normal)
        
        leftItemButton.setImage(UIImage.init(named: "shouye_icon_scan_white"), for: .normal)
        leftItemButton.addTarget(self, action: #selector(leftButtonItemClick), for: .touchUpInside)
        leftItemButton.adjustsImageWhenHighlighted = false//使触摸模式下按钮也不会变暗（半透明）
        leftItemButton.adjustsImageWhenDisabled = false//使禁用模式下按钮也不会变暗（半透明）
        
        rightItemButton.setImage(UIImage.init(named: "shouye_icon_sort_white"), for: .normal)
        rightItemButton.addTarget(self, action: #selector(rightButtonItemClick), for: .touchUpInside)
        rightItemButton.adjustsImageWhenHighlighted = false
        rightItemButton.adjustsImageWhenDisabled = false
        
        rightRItemButton.setImage(UIImage.init(named: "icon_gouwuche_title_white"), for: .normal)
        rightRItemButton.addTarget(self, action: #selector(rightRButtonItemClick), for: .touchUpInside)
        rightRItemButton.adjustsImageWhenHighlighted = false
        rightRItemButton.adjustsImageWhenDisabled = false
        
        topSearchView.backgroundColor = UIColor.white
        topSearchView.layer.cornerRadius = 16
        topSearchView.layer.masksToBounds = true
        

        
        searchButton.setTitle("彩电年终内购会", for: .normal)
        searchButton.setTitleColor(UIColor.lightGray, for: .normal)
        searchButton.setImage(UIImage.init(named: "group_home_search_gray"), for: .normal)
        searchButton.adjustsImageWhenHighlighted = false
        searchButton.adjustsImageWhenDisabled = false
        searchButton.adjustsImageWhenHighlighted = true
        searchButton.contentHorizontalAlignment = .left
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        searchButton.addTarget(self, action: #selector(searchButtonClick), for: .touchUpInside)
        
        
        voiceButton.adjustsImageWhenHighlighted = false
        voiceButton.addTarget(self, action: #selector(voiceButtonClick), for: .touchUpInside)
        voiceButton.setImage(UIImage.init(named: "icon_voice_search"), for: .normal)
        voiceButton.adjustsImageWhenHighlighted = false
        voiceButton.adjustsImageWhenDisabled = false
        
    }
    @objc func leftButtonItemClick()  {
        concurrentQueue.async(execute: leftItemClickBlock);
    }
    @objc func rightButtonItemClick()  {
        concurrentQueue.async(execute: rightItemClickBlock);
    }
    @objc func rightRButtonItemClick()  {
        concurrentQueue.async(execute: rightRItemClickBlock);
    }
    @objc func searchButtonClick()  {
        concurrentQueue.async(execute: searchButtonClickBlock);
    }
    @objc func voiceButtonClick()  {
        concurrentQueue.async(execute: voiceButtonClickBlock);
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        /*
         必须先添加addSubview才能使用约束
         */
        self.addSubview(leftItemButton)
        self.addSubview(rightItemButton)
        self.addSubview(rightRItemButton)
        self.addSubview(topSearchView)
        topSearchView.addSubview(searchButton)
        topSearchView.addSubview(voiceButton)
        
        leftItemButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(YFStatusBarHeight)
            make.left.equalTo(self.snp.left).offset(0)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        rightItemButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(leftItemButton.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-0)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        rightRItemButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(leftItemButton.snp.centerY)
            make.right.equalTo(rightItemButton.snp.left).offset(5)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        topSearchView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(leftItemButton.snp.right).offset(5)
            make.right.equalTo(rightRItemButton.snp.left).offset(5)
            make.height.equalTo(32)
            make.centerY.equalTo(rightRItemButton)
        }
        searchButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(topSearchView)
            make.top.equalTo(topSearchView)
            make.height.equalTo(topSearchView)
            make.right.equalTo(topSearchView).offset(-2*10)
        }
        voiceButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(topSearchView)
            make.centerY.equalTo(topSearchView)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
    }

}
