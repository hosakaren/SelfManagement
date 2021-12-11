//
//  UIDialogViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/17.
//

import UIKit

public class UIDialogViewControllerBase: UIViewController {
        
    var isCloseTapBackground: Bool = true
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        /// 調べる
        view.tag = -1
        
        transitioningDelegate = self
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        
        self.view.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isCloseTapBackground {
            for touch: UITouch in touches where touch.view!.tag == -1 {
                dismiss(animated: true, completion: nil)
            }
        }
    }
        
}

extension UIDialogViewControllerBase: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Animation(isShow: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Animation(isShow: false)
    }
}

class Animation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isShow: Bool

    init(isShow: Bool) {
        self.isShow = isShow
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if isShow {
            return 0.5
        } else {
            return 0.25
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isShow {
            presentAnimate(transitionContext: transitionContext)
        } else {
            dismissAnimate(transitionContext: transitionContext)
        }
    }
    
    private func presentAnimate(transitionContext: UIViewControllerContextTransitioning) {
        let alertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UIDialogViewControllerBase

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                alertVC.view.alpha = 0.0
            },
            completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
    
    private func dismissAnimate(transitionContext: UIViewControllerContextTransitioning) {
        let alertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UIDialogViewControllerBase

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                alertVC.view.alpha = 0.0
            },
            completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
    
}
