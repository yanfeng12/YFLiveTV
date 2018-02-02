//
//  DiscoveryViewController.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/24.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit

private let EdgeMargin : CGFloat = 8
private let AnchorCellID = "kAnchorCellID"

class DiscoveryViewController: YFBaseViewController,UICollectionViewDataSource, WaterfallLayoutDataSource, UICollectionViewDelegate{
    
    var discModels = [DiscoveryModel]()

    
    //懒加载
    fileprivate lazy var collection:UICollectionView = {
        let layout:WaterfallLayout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: EdgeMargin, left: EdgeMargin, bottom: EdgeMargin, right: EdgeMargin)
        layout.minimumLineSpacing = EdgeMargin
        layout.minimumInteritemSpacing = EdgeMargin
        layout.dataSource = self
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect(x: 0, y: YFStatusBarAndNavigationBarHeight, width: ScreenW, height: ScreenH - YFStatusBarAndNavigationBarHeight), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DiscoveryCell", bundle: nil),forCellWithReuseIdentifier: AnchorCellID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setupUI()

        loadNetworks(index: 0)
    }
    func setNav()  {
        let nav:DiscoveryNavbar = DiscoveryNavbar(frame: CGRect(x: 0, y: 0, width: Int(ScreenW), height: YFStatusBarAndNavigationBarHeight))
        view.addSubview(nav)
        nav.backgroundColor = YFColorBase

        //swift调用按钮方法
        nav.leftItemClickBlock = DispatchWorkItem.init(block: {
            print("点击了导航栏左边按钮")
        })
        nav.rightItemClickBlock = DispatchWorkItem.init(block: {
            print("点击了导航栏右边按钮")
        })
        nav.rightRItemClickBlock = DispatchWorkItem.init(block: {
            print("点击了导航栏右边按钮")
        })
        nav.searchButtonClickBlock = DispatchWorkItem.init(block: {
            print("点击了导航栏搜索按钮")
        })
        nav.voiceButtonClickBlock = DispatchWorkItem.init(block: {
            print("点击了导航栏声音按钮")
        })
            
      
        
    }
    func loadNetworks(index : Int)  {
        //获取数据
        // https://qf.56.com/home/v4/moreAnchor.ios?type=0&index=30&size=48
        NetworkTools.requestData(.GET, URLString: "http://qf.56.com/home/v4/moreAnchor.ios", parameters: ["type" : 0, "index" : index, "size" : 48], finishedCallback: { (result) -> Void in
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }

            for (index, dict) in dataArray.enumerated() {
                let model = DiscoveryModel()
                model.isEvenIndex = dict["index"] as? Bool
                model.focus = dict["focus"] as? Int
                model.live = dict["live"] as? Int
                model.name = dict["name"] as? String
                model.pic51 = dict["pic51"] as? String
                model.pic74 = dict["pic74"] as? String
                
                self.discModels.append(model)
            }
            self.collection.reloadData()
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func waterfalllayout(layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? kScreenWidth * 2 / 3 : kScreenWidth * 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnchorCellID, for: indexPath) as! DiscoveryCell
        cell.discoveryModel = discModels[indexPath.item]
        if indexPath.item == discModels.count - 1
        {
            loadNetworks(index: discModels.count)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RomeViewViewController()
        roomVc.model = discModels[indexPath.item]
        roomVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(roomVc, animated: true)
    }
}
// MARK:- 设置UI界面内容
extension DiscoveryViewController {
    fileprivate func setupUI() {
        view.addSubview(collection)
    }
}
