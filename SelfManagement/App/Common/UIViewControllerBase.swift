//
//  UIViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit

open class UIViewControllerBase: UIViewController {
    
    public func viewId() -> ViewIdEnum! { return nil }
    
    /// 画面表示後
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバー設定
        if getViewInfo().isNavigationBar {
            settingNaviBar()
        }
        
        //ボトムタブ表示
        if getViewInfo().isBottomTabBar {
            //createBottomTab()
        }
    }
    
    // FG遷移
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.init(named: "view_back_ground")
    }
    
    /// 画面遷移
    public func moveScreen(_ id: ViewIdEnum, animated: Bool = true) {
        //次の画面取得
        let storyboard: UIStoryboard = UIStoryboard(name: id.getViewInfo().fileName, bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        nextView?.modalPresentationStyle = .fullScreen
        // 画面遷移アニメーション設定
        self.storyboard?.instantiateInitialViewController()?.modalTransitionStyle = .partialCurl
        // 遷移
        self.present(nextView!, animated: animated)
    }
    
    /// 前の画面に戻る
    public func goBack(animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
    
    /// ナビゲーションバー設定
    private func settingNaviBar() {
        if let naviController = self.navigationController {
            self.navigationItem.title = getViewInfo().title
            naviController.navigationBar.backgroundColor = UIColor.init(named: "view_back_ground")
            naviController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            if let rightBarButtonItems = navigationItem.rightBarButtonItems {
                for rightItem in rightBarButtonItems {
                    rightItem.tintColor = .white
                }
            }
            
            if getViewInfo().isBackBtn {
                let backBtnItem = UIBarButtonItem.init(
                    image: FileAdmin.image("back_btn_image"),
                    style: .plain,
                    target: self,
                    action: #selector(tapBackBtn))
                navigationItem.leftBarButtonItem = backBtnItem
                navigationItem.leftBarButtonItem?.tintColor = .white
                
                // スワイプで戻る設定
                naviController.interactivePopGestureRecognizer?.isEnabled = false
                setupLeftSwipeBack()
            }
        }
    }
    
    /// スワイプで戻るセットアップ
    private func setupLeftSwipeBack() {
            if let screenCount = navigationController?.viewControllers.count,
           screenCount > 0 {
            let edgeSwipeGesture =
                UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeBack))
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
    
    /// 戻るボタンタップ
    @objc func tapBackBtn() {
        goBack()
    }
    
    /// View情報取得
    private func getViewInfo() -> (
        fileName: String,
        title: String,
        isNavigationBar: Bool, isBackBtn: Bool, isBottomTabBar: Bool) {
            viewId().getViewInfo()
    }
    
}

extension UIViewControllerBase: UITabBarDelegate {
    
    // ボトムタブ生成
    public func createBottomTab() {
        
        let tabBar = UITabBar()
        //デリゲートを設定する
        tabBar.delegate = self
        
        // ボタン生成
        let tab1: UITabBarItem = UITabBarItem.init(title: Localize.ja("task_tag"), image: FileAdmin.image("task_image"), tag: 1)
        let tab2: UITabBarItem = UITabBarItem.init(title: Localize.ja("money_tag"), image: nil, tag: 2)
        let tab3: UITabBarItem = UITabBarItem.init(title: Localize.ja("setting_tag"), image: FileAdmin.image("setting_image"), tag: 3)
        
        //ボタンをタブバーに配置する
        tabBar.items = [tab1, tab2, tab3]
        
        // tabの位置指定
        tabBar.frame = CGRect(
            x: 0,
            y: UIScreen.main.bounds.height - 50,
            width: UIScreen.main.bounds.width,
            height: 50
        )
        
        tabBar.barTintColor = UIColor.init(named: "view_back_ground")
        tabBar.isTranslucent = false
        //ボタンを押した時の色
        tabBar.tintColor = UIColor.red
        //選択されていないボタンの色
        tabBar.unselectedItemTintColor = UIColor.white
        
        self.view.addSubview(tabBar)
    }
    
    open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1: moveScreen(.task_list, animated: true)
        case 2: print("")
        case 3: print("")
        default: break
        }
    }
}
