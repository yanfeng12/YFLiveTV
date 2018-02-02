//
//  YFTabBarViewController.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/24.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit

class YFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UITabBarControllerDelegate
        // Do any additional setup after loading the view.
        self.makeTabbar()
        self.addChildVC()
    }
    func makeTabbar()  {
        let tabbar:YFTabBar = YFTabBar()
        tabbar.backgroundColor = UIColor.white
        self.setValue(tabbar, forKey: "tabBar")
        
    }
    func addChildVC()  {
        let childArray:NSArray = [
            [MallClassKey  : "HomePageViewController",
             MallTitleKey  : "首页",
             MallImgKey    : "Firstunselected",
             MallSelImgKey : "Firstselected"],
            
            [MallClassKey  : "DiscoveryViewController",
             MallTitleKey  : "发现",
             MallImgKey    : "Thirdunselected",
             MallSelImgKey : "Thirdselected"],
            
            [MallClassKey  : "MessageViewController",
             MallTitleKey  : "消息",
             MallImgKey    : "Secondunselected",
             MallSelImgKey : "Secondselected"],
            
            [MallClassKey  : "MineViewController",
             MallTitleKey  : "我的",
             MallImgKey    : "Fourthunselected",
             MallSelImgKey : "Fourthselected"],
            
            ]
        
        childArray.enumerateObjects { (character, idx, stop) -> Void in
            
            
            /*
             当根据一个类名来创建类的时候：OC中直接调用此方法即可
             
             UIViewController * vc = NSClassFromString(@"DiscoverViewController")
             
             而在Switf引入了命名空间这个概念，我们对一个类的调用实质上调用的是当前【命名空间.该类对应的类名】
             
             比如当前工程的命名空间为Project；其中有一个类名为MainBarController,当我们通过调用这个类进行实例化操作的时候：
             
             let MainVC = MainBarController()
             
             真正的完整的调用应该是【Project.MainBarController】而不是【MainBarController】
             
             所以在我们通过类名字符串"MainBarController"来调用NSClassFromString("MainBarController")方法企图拿到该类时是行不通的，此处的方法字符串参数必须是全称：命名空间.该类类名：
             
             NSClassFromString("Project .MainBarController")
             
             
             所以因为命名空间的存在，在Swift中就必须先拿到完整的类名
             */
            /*
             ①拿到命名空间的名称：
             
             命名空间的名称位于info.plist文件中的Executable file键值对应的Value
             
             通过右键info.plist文件--->Open As--->Source Code打开.plist的源码
             
             找到Executable file键值对应的真正键值CFBundleExecutable，再通过真正的键值拿到命名空间的名称
             */
            guard   let NameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else{
                
                return  //无法获取到命名空间  后续代码不用执行
                
            }
            /*
             ②根据完整字符串类名获取对应的完整类名.此时再调用NSClassFromString方法
             拿到返回的控制器类型后，因为Swift中关于该方法的定义为：  【func NSClassFromString(aClassName: String) -> AnyClass?】
             
             
             返回值类型为AnyClass? 所以还需要确定该类型
             */
            guard  let TrueVC = NSClassFromString(NameSpace + "." + ((character as!NSDictionary).value(forKey: MallClassKey)as! String))else{
                
                return  //无法获取到该类 后续代码不用执行
                
            }
            /*
              ③ 确定控制器类型
             */
            guard let Type = TrueVC as? YFBaseViewController.Type else{
                
                return  //无法获取到该控制器类型 后续代码不用执行
                
            }
            /*
             ④最后才能对该类型的类进行实例化和后续操作
             */
            let vc = Type.init()
            
            let nav:YFNavigationViewController = YFNavigationViewController(rootViewController: vc)
            
            let item:UITabBarItem = nav.tabBarItem
            item.image = UIImage(named: ((character as!NSDictionary).value(forKey: MallImgKey)as! String))
            // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
            item.selectedImage = UIImage(named: ((character as!NSDictionary).value(forKey: MallSelImgKey)as! String))?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
            let dictHome:NSDictionary = NSDictionary(object: UIColor.init(red: 31/255.0, green: 185/255.0, blue: 235/255.0, alpha: 1), forKey: NSAttributedStringKey.foregroundColor as NSCopying)
            item.title = (character as!NSDictionary).value(forKey: MallTitleKey)as? String
            item.setTitleTextAttributes(dictHome as? [NSAttributedStringKey : Any], for: .selected)
            
            self.addChildViewController(nav)
            
        }

    }

    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //点击tabBarItem动画
        self.tabBarButtonClick(tabBarButton: self.getTabBarButton())
    }

    func getTabBarButton() -> UIControl {
        let tabBarButtons:NSMutableArray = NSMutableArray(capacity: 0)
        for tabBarButton:UIView in self.tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!)
            {
               tabBarButtons.add(tabBarButton)
            }
        }
        let tabBarButton:UIControl = tabBarButtons.object(at: self.selectedIndex) as! UIControl
        return tabBarButton
    }
    /******   用#pragma mark 函数说明，来生成一个函数的说明X
     
     但在swift中，这个语法就不支持了，毕竟它是属于C的语法，于是就有了新的一些语法，如：// MARK: // FIXME // TODO: 等      *******/
    // MARK:点击动画
    func tabBarButtonClick(tabBarButton:UIControl)  {
        for imageView:UIView in tabBarButton.subviews {
            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!)
            {
                //需要实现的帧动画,这里根据自己需求改动
                let animation:CAKeyframeAnimation = CAKeyframeAnimation()
                animation.keyPath = "transform.scale";
                animation.values = [1.0,1.1,0.9,1.0];
                animation.duration = 0.3;
                animation.calculationMode = kCAAnimationCubic;
                imageView.layer.add(animation, forKey: nil)
            }
        }
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

}
