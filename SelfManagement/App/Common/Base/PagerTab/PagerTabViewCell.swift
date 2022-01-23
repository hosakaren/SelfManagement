//
//  PagerTabViewCell.swift
//  SelfManagement
//
//  Created by hosakaren on 2022/01/22.
//

import UIKit

class PagerTabViewCell: UICollectionViewCell {

    /// tab_title
    @IBOutlet weak var tabTitleLabel: UILabel!
    /// status_bar
    @IBOutlet weak var statusBarView: UIView!
    
    fileprivate var tapCellClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Cellのsetup
    public func setupCell(
        tapCellClosure: (() -> Void)?,
        title: String
    ) {
        self.tapCellClosure = tapCellClosure
        self.tabTitleLabel.text = title
    }
    
    /// Cellのupdate

    /// Pager_cell_tap
    @IBAction func tapPagerTabCell(_ sender: Any) {
        self.tapCellClosure?()
    }
}
