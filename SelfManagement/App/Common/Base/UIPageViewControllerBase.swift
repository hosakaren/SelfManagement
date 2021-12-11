//
//  UIPageViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/12/03.
//

import UIKit

open class UIPageViewControllerBase: UIPageViewController {

    var pageViewControllers: [UIViewController] = []
    
    private var beforeIndex: Int = 0
    private var currentIndex: Int? {
        if let viewController = self.viewControllers?.first,
           let index = pageViewControllers.firstIndex(of: viewController) {
            return index
        } else {
            return nil
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
    }
}

extension UIPageViewControllerBase: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        getNextViewController(vc: viewController, isAfter: false)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        getNextViewController(vc: viewController, isAfter: true)
    }
    
    private func getNextViewController(vc: UIViewController, isAfter: Bool) -> UIViewController? {
        
        guard var index = pageViewControllers.firstIndex(of: vc) else { return nil }
        
        index = isAfter ? index + 1 : index - 1
        
        if index < 0 || index >= pageViewControllers.count {
            return nil
        } else   {
            return pageViewControllers[index]
        }
    }
    
    
}

extension UIPageViewControllerBase: UIPageViewControllerDelegate {
    
}
