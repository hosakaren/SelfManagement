//
//  UIBaseView.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/12/01.
//

import UIKit

@IBDesignable open class UIBaseView: UIView {
    
    private var displayView: UIView?
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNibView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        displayView?.frame = bounds
    }
    
    private func loadNibView() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle.lib)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        addSubview(view)
        
        displayView = view
    }
}
