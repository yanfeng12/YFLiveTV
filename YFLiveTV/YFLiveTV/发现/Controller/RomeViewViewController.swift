//
//  RomeViewViewController.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/2/2.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit
import Kingfisher
import IJKMediaFramework
class RomeViewViewController: YFBaseViewController,Emitterable {

    fileprivate var ijkPlayer : IJKFFMoviePlayerController?
    
    @IBOutlet weak var bgImageViews: UIImageView!
    
    // MARK: 对外属性
    var model : DiscoveryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAnchorLiveAddress()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ijkPlayer?.shutdown()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func BackBtnClick(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func StackBtnClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("评论")
            break
        case 1:
            print("分享")
            break
        case 2:
            print("送礼物")
            break
        case 3:
            print("更多")
            break
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            sender.isSelected ? startEmittering(point) : stopEmittering()
            print("点赞")
            break
        default:
            print("未处理")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK:- 设置UI界面内容
extension RomeViewViewController {
    fileprivate func setupUI(){
        setupBlurView()
    }
    
    fileprivate func setupBlurView() {
        //设置毛玻璃效果
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        /*
         自动调整view的宽和高，保证上下左右边距不变。如把tableView设置为此属性，那么无论viewController的view是多大，都能自动铺满
         */
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageViews.bounds
        bgImageViews.addSubview(blurView)
    }
}
// MARK:- 请求主播信息
extension RomeViewViewController {
    fileprivate func loadAnchorLiveAddress() {
        // 1.获取请求url
        let URLString = "http://qf.56.com/play/v2/preLoading.ios"
        
        // 2.获取请求参数
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056", "signature" : "f69f4d7d2feb3840f9294179cbcb913f", "roomId" : model!.roomid as Any, "userId" : model!.uid as Any]
        
        NetworkTools.requestData(.GET, URLString: URLString, parameters: parameters, finishedCallback: { result in
            
            // 1.将result转成字典模型
            let resultDict = result as? [String : Any]
            
            // 2.从字典中取数据
            let infoDict = resultDict?["message"] as? [String : Any]
            
            // 3.获取请求直播地址URL
            guard let rURL = infoDict?["rUrl"] as? String else { return }
            
            // 4.请求直播地址
            NetworkTools.requestData(.GET, URLString: rURL, finishedCallback: { (result) in
                let resultDict = result as? [String : Any]
                let liveURLString = resultDict?["url"] as? String
                
                self.displayLiveView(liveURLString)
            })
        })
    }
    
    fileprivate func displayLiveView(_ liveURLString : String?) {
        // 1.获取直播地址
        guard let liveURLString = liveURLString else {
            return
        }
        
        // 2.使用IJKPlayer播放视频
        let options = IJKFFOptions.byDefault()
        options?.setOptionIntValue(1, forKey: "videotoolbox", of: kIJKFFOptionCategoryPlayer)
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: liveURLString, with: options)
        
        // 3.设置frame已经添加到其他View中
        if model?.push == 1 {
            ijkPlayer?.view.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: bgImageViews.bounds.width, height: bgImageViews.bounds.width * 3 / 4))
            ijkPlayer?.view.center = bgImageViews.center
        } else {
            ijkPlayer?.view.frame = bgImageViews.bounds
        }
        bgImageViews.addSubview(ijkPlayer!.view)
        ijkPlayer?.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 4.开始播放
        ijkPlayer?.prepareToPlay()
    }
}
