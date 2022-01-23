//
//  PagerTabCell.swift
//  SelfManagement
//
//  Created by hosakaren on 2022/01/13.
//

import UIKit

class PagerTabCell: UICollectionViewCell {
    
    var tabItemButtonPressedBlock: (() -> ())?
    
    // TabOption
    var option: TabPageOption = TabPageOption() {
        didSet {
            currentBarViewHeightConstraint.constant = option.currentBarHeight
        }
    }
    
    // TabTitle
    @IBOutlet fileprivate weak var itemLabel: UILabel!
    // 選択中バーView
    @IBOutlet fileprivate weak var currentBarView: UIView!
    // 選択中バーView制約
    @IBOutlet fileprivate weak var currentBarViewHeightConstraint: NSLayoutConstraint!
    
    var item: String = "" {
        didSet {
            itemLabel.text = item
            // itemLabel動的にサイズ変更
            itemLabel.invalidateIntrinsicContentSize()
            // Cellのサイズ変更
            invalidateIntrinsicContentSize()
        }
    }
    
    var isCurrent: Bool = false {
        didSet {
            currentBarView.isHidden = !isCurrent
            if isCurrent {
                highlightTitle()
            } else {
                unHighlightTitle()
            }
            currentBarView.backgroundColor = option.currentColor
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        currentBarView.isHidden = true
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if item.count == 0 {
            return CGSize.zero
        }
        
        return intrinsicContentSize
    }
    
    class func cellIdentifier() -> String {
        "PagerTabCell"
    }
    
    override var intrinsicContentSize: CGSize {
        let width: CGFloat
        
        if let tabWidth = option.tabWidth , tabWidth > 0.0 {
            width = tabWidth
        } else {
            width = itemLabel.intrinsicContentSize.width + option.tabMargin * 2
        }
        let size = CGSize(width: width, height: option.tabHeight)
        return size
    }
    
    func hideCurrentBarView() {
        currentBarView.isHidden = true
    }
    
    func showCurrentBarView() {
        currentBarView.isHidden = false
    }
    
    func highlightTitle() {
        itemLabel.textColor = option.currentColor
        itemLabel.font = UIFont.boldSystemFont(ofSize: option.fontSize)
    }
    
    func unHighlightTitle() {
        itemLabel.textColor = option.defaultColor
        itemLabel.font = UIFont.systemFont(ofSize: option.fontSize)
    }
    
    @IBAction fileprivate func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonPressedBlock?()
    }
    
}
