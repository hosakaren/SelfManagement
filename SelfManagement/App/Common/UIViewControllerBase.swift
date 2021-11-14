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
        
        self.view.backgroundColor = UIColor.init(named: "view_back_ground")
        // ナビゲーションバー設定
        settingNaviBar()
        
        //ボトムタブ表示
        if getViewInfo().isBottomTabBar {
            createBottomTab()
        }
    }
    
    // FG遷移
    public override func viewWillAppear(_ animated: Bool) {
        
    }
    
    /// 画面遷移
    public func moveScreen(_ id: ViewIdEnum) {
        //次の画面取得
        let storyboard: UIStoryboard = UIStoryboard(name: id.getViewInfo().view, bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        nextView?.modalPresentationStyle = .fullScreen
        // 遷移
        self.present(nextView!, animated: false, completion: nil)
    }
    
    /// 前の画面に戻る
    public func goBack() {
        dismiss(animated: false, completion: nil)
    }
    
    /// ナビゲーションバー設定
    private func settingNaviBar() {
        if let naviController = self.navigationController {
            self.navigationItem.title = getViewInfo().title
            naviController.navigationBar.backgroundColor = .clear
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
            }
        }
    }
    
    /// 戻るボタンタップ
    @objc func tapBackBtn() {
        goBack()
    }
    
    /// View情報取得
    private func getViewInfo() -> (view: String, title: String, isNavigationBar: Bool, isBackBtn: Bool, isBottomTabBar: Bool) { viewId().getViewInfo()
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
        case 1: moveScreen(.task_list)
        case 2: print("")
        case 3: print("")
        default: break
        }
    }
}