//
//  UITabViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/12/13.
//

import UIKit

open class UITabViewControllerBase: UITabBarController {
        
    private var botttomTabControllers: [UINavigationControllerBase]? = nil
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        createBottomTab()
    }
    
    private func createBottomTab() {
        let tab1VC = UIStoryboard(name: TaskListController.fileName, bundle: nil).instantiateInitialViewController()
        let tab1Controller = UINavigationControllerBase(rootViewController: tab1VC!)
        let tab1BarItem = UITabBarItem(
            title: Localize.ja("task_tag"),
            image: UIImage.init(systemName: Localize.filePath("task_image")),
            tag: 0
        )
        tab1BarItem.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        tab1Controller.tabBarItem = tab1BarItem
        
        let tab2VC = getParentMoneyViewController()
        let tab2Controller = UINavigationControllerBase(rootViewController: tab2VC)
        let tab2BarItem = UITabBarItem(
            title: Localize.ja("task_tag"),
            image: UIImage.init(systemName: Localize.filePath("task_image")),
            tag: 1
        )
        tab2BarItem.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        tab2Controller.tabBarItem = tab2BarItem
        
        UITabBar.appearance().unselectedItemTintColor = .white
        // 選択された時
        UITabBar.appearance().tintColor = .red
        
        UITabBarItem.appearance().badgeColor = .white
        botttomTabControllers = [tab1Controller, tab2Controller]

        self.viewControllers = botttomTabControllers
        self.setViewControllers(self.viewControllers, animated: false)
    }
    
    private func getParentMoneyViewController() -> UIParentPagerViewControllerBase {
        let parentVC = UIStoryboard(name: "UIParentPagerView", bundle: nil)
            .instantiateInitialViewController() as! UIParentPagerViewControllerBase
//        parentVC.setupChildPagerViewController(childPagerVC: <#T##UIChildPagerViewControllerBase#>)
        
        return parentVC
    }
}
