//
//  UINavigationControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/30.
//

import UIKit

open class UINavigationControllerBase: UINavigationController, UINavigationControllerDelegate {
    
    public func viewId() -> ViewIdEnum { return .none }

    public var isHiddenNavigationBar: Bool = false {
        didSet {
            if isHiddenNavigationBar {
                self.setNavigationBarHidden(true, animated: true)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = true
        self.delegate = self
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.init(named: "view_back_ground")
         
        let viewInfo = viewId().getViewInfo()
        self.navigationItem.title = viewInfo.title
        
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if isHiddenNavigationBar {
            self.setNavigationBarHidden(false, animated: true)
        }
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        
        if isNavigationBarHidden,
           self.viewControllers.count < 2 {
            self.setNavigationBarHidden(true, animated: true)
        }
        return vc
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated)
        if isNavigationBarHidden,
           self.viewControllers.count < 2 {
            self.setNavigationBarHidden(true, animated: true)
        }
        return vcs
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcs = super.popToRootViewController(animated: animated)
        if isNavigationBarHidden,
           self.viewControllers.count < 2 {
            self.setNavigationBarHidden(true, animated: true)
        }
        return vcs
    }
    
    public func moveScreen(_ id: ViewIdEnum, animated: Bool = true) {
        //次の画面取得
        let storyboard: UIStoryboard = UIStoryboard(name: id.getViewInfo().fileName, bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        nextView?.modalPresentationStyle = .fullScreen
        // 画面遷移アニメーション設定
        //self.storyboard?.instantiateInitialViewController()?.modalTransitionStyle = .crossDissolve
        // 遷移
        self.pushViewController(nextView!, animated: true)
    }
}
