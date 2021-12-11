//
//  UITabViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/12/03.
//

import UIKit

public class UITabViewControllerBase: UIViewControllerBase {
    
    public override func viewId() -> ViewIdEnum { return .bottom_tab }

    private var selectedIndex: Int = 0
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var contentView: UIView!
    
    public var tab1View: UIViewControllerBase?

    public var tab1ViewController: UINavigationControllerBase!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.delegate = self
        
        createTabView()
        
        moveScreen(.task_list, animated: true)
    }
    
    public func createTabView() {
        
        setTab1View()
        
        tab1ViewController = UINavigationControllerBase(rootViewController: tab1View!)
        tab1ViewController.tabBarItem = UITabBarItem(
            title: tab1View!.title,
            image: FileAdmin.image("task_image"),
            tag: 0
        )
        
    }
    
    private func setTabViewControllers(displayIndex: Int) {
        tabBar.items = [tab1ViewController.tabBarItem]
        
        let selectedItem = tabBar.items?[displayIndex]
        tabBar.selectedItem = selectedItem
        
        selectedIndex = displayIndex
    }
    
    private func setTab1View() {
        let storyboard: UIStoryboard = UIStoryboard(name: ViewIdEnum.task_list.getViewInfo().fileName, bundle: nil)
        tab1View = storyboard.instantiateInitialViewController()
    }
}

extension UITabViewControllerBase: UITabBarDelegate {
    
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1: moveScreen(.task_list, animated: true)
        case 2: print("")
        case 3: print("")
        default: break
        }
    }
}

extension UITabViewControllerBase: StoryBoardNameProtocol {
    public static var fileName: String { "UITabView" }
    public static var title: String { "" }
}
