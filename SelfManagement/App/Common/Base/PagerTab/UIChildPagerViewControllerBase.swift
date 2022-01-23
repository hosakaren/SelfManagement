//
//  UIChildPagerViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2022/01/22.
//

import UIKit

public class UIChildPagerViewControllerBase: UIPageViewController {
    
    /// vcList
    public var viewControllerList: [(viewController: UIViewControllerBase, title: String)] = []
    /// 表示中のvcのIndexの値
    fileprivate var displayIndexVC: Int = 0
    /// 次に表示したいVCのIndex
    /// CollectionViewの場合使われる
    fileprivate var parentPagerTabIndex: Int? = nil
    
    public init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    public required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        /// 子ViewControllerをSet
        setViewControllers(viewControllerList.compactMap{ $0.viewController },
                           direction: .forward,
                           animated: true,
                           completion: nil
        )
    }
    
    /// childViewControllerのSetup
    public func setupChildVC(viewControllerList: [(viewController: UIViewControllerBase, title: String)]) {
        self.viewControllerList = viewControllerList
    }
}

// MARK: - UIPageViewControllerDelegate
extension UIChildPagerViewControllerBase: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}

// MARK: - UIPageViewControllerDataSource
extension UIChildPagerViewControllerBase: UIPageViewControllerDataSource {
    
    // 1つ前のvcに移動
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(isAfter: false, vc: viewController as! UIViewControllerBase)
    }
    
    // 1つ後のvcに移動
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(isAfter: true, vc: viewController as! UIViewControllerBase)
    }
    
    // 次のViewControllerを返す
    private func nextViewController(isAfter: Bool, vc: UIViewControllerBase) -> UIViewControllerBase? {
        
        let afterIndex: Int = displayIndexVC + 1
        let beforeIndex: Int = displayIndexVC - 1
        let vcCount: Int = viewControllerList.count
        
        // Indexoutof回避
        if (afterIndex < 0 || afterIndex < vcCount)
            || (beforeIndex < 0 || beforeIndex < vcCount) { return nil }
        
        displayIndexVC = isAfter ? afterIndex : beforeIndex
        
        return viewControllerList[displayIndexVC].viewController
    }
    
    public func changePagerTabCollectionCell(index: Int) {
        
    }
    
}

