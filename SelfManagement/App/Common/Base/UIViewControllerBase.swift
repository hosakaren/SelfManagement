//
//  UIViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit

open class UIViewControllerBase: UIViewController {

    public func viewId() -> ViewIdEnum { return .none }

    /// 画面表示後
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // FG遷移
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.init(named: "view_back_ground")
        
        // ナビゲーションバー設定
        settingNaviBar()
    }
    
    /// 画面遷移
    public func moveScreen(_ id: ViewIdEnum, animated: Bool = true) {
        //次の画面取得
        let storyboard: UIStoryboard = UIStoryboard(name: id.getViewInfo().fileName, bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        nextView?.modalPresentationStyle = .fullScreen
        // 画面遷移アニメーション設定
        self.storyboard?.instantiateInitialViewController()?.modalTransitionStyle = .crossDissolve
        // 遷移
        if let naviController = self.navigationController {
            naviController.pushViewController(nextView!, animated: true)
        } else {
            self.present(nextView!, animated: animated)
        }
    }
    
    /// 前の画面に戻る
    public func goBack(animated: Bool = true) {
        if let naviController = self.navigationController {
            naviController.popViewController(animated: animated)
        } else {
            dismiss(animated: animated, completion: nil)
        }
    }
    
    /// ナビゲーションバー設定
    private func settingNaviBar() {
        if let naviController = self.navigationController {
            let naviBar = naviController.navigationBar
            let naviItem = self.navigationItem
            
            naviController.interactivePopGestureRecognizer?.isEnabled = true

            naviBar.isTranslucent = true
            naviBar.backgroundColor = UIColor.init(named: "view_back_ground")
            naviBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            naviItem.title = getViewInfo().title
            
            naviItem.rightBarButtonItems?.forEach { item in
                item.tintColor = .white
            }
            
            naviItem.leftBarButtonItems?.forEach { item in
                item.tintColor = .white
            }
            
            naviItem.backButtonTitle = ""
            naviBar.tintColor = .white;
            
            setupLeftSwipeBack(naviController)
        }
    }
    
    /// スワイプで戻るセットアップ
    private func setupLeftSwipeBack(_ naviController: UINavigationController) {
        if naviController.viewControllers.count > 0 {
            let edgeSwipeGesture = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(swipeBack)
            )
            edgeSwipeGesture.edges = .left
            self.view.addGestureRecognizer(edgeSwipeGesture)
        }
    }
    /// スワイプで戻る
    @objc func swipeBack(recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    /// View情報取得
    private func getViewInfo() -> (
        fileName: String,
        title: String,
        isNavigationBar: Bool, isBackBtn: Bool, isBottomTabBar: Bool) {
            viewId().getViewInfo()
    }
    
}
