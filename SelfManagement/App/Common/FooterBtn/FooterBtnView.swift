//
//  FooterBtnController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

import UIKit

@IBDesignable class FooterBtnView: UIView {

    @IBOutlet weak var singleBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    public var btnType: FooterBtnEnum!
    public var tapBtnCallbackFunc: ((ReturnFooterBtnEnum) -> Void)?
    
    public var displayView: UIView?
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        displayView?.frame = bounds
    }
    
    private func loadFromNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle.lib)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        // ビューの追加
        addSubview(view)
        
        displayView = view
    }
    
    
    public func setupBtn(
        btnType: FooterBtnEnum,
        tapBtnCallbackFunc: ((ReturnFooterBtnEnum) -> Void)?
    ) {
        self.btnType = btnType
        self.tapBtnCallbackFunc = tapBtnCallbackFunc
        
        loadView()
    }
    
    private func loadView() {
        singleBtn.layer.borderColor = UIColor.white.cgColor
        singleBtn.layer.borderWidth = 1
        leftBtn.layer.borderColor = UIColor.white.cgColor
        leftBtn.layer.borderWidth = 1
        rightBtn.layer.borderColor = UIColor.white.cgColor
        rightBtn.layer.borderWidth = 1
        
        switch self.btnType {
        case .close:
            singleBtn.isHidden = false
            leftBtn.isHidden = true
            rightBtn.isHidden = true
            
            singleBtn.isEnabled = true
            leftBtn.isEnabled = false
            rightBtn.isEnabled = false
            
            singleBtn.setTitle(btnType.btnLabel[0], for: .normal)
            
        case .save:
            singleBtn.isHidden = false
            leftBtn.isHidden = true
            rightBtn.isHidden = true
            
            singleBtn.isEnabled = true
            leftBtn.isEnabled = false
            rightBtn.isEnabled = false
            
            singleBtn.setTitle(btnType.btnLabel[0], for: .normal)
        case .save_and_cancel:
            singleBtn.isHidden = true
            leftBtn.isHidden = false
            rightBtn.isHidden = false
            
            singleBtn.isEnabled = false
            leftBtn.isEnabled = true
            rightBtn.isEnabled = true
            
            leftBtn.setTitle(btnType.btnLabel[0], for: .normal)
            rightBtn.setTitle(btnType.btnLabel[1], for: .normal)
        case .yes_and_no:
            singleBtn.isHidden = true
            leftBtn.isHidden = false
            rightBtn.isHidden = false
            
            singleBtn.isEnabled = false
            leftBtn.isEnabled = true
            rightBtn.isEnabled = true
            
            leftBtn.setTitle(btnType.btnLabel[0], for: .normal)
            rightBtn.setTitle(btnType.btnLabel[1], for: .normal)
        default: break
        }
    }
    
    /// singleBtnタップ
    @IBAction func tapSingleBtn(_ sender: Any) {
        tapBtnCallbackFunc?(.close)
    }
    /// leftBtnタップ
    @IBAction func tapLeftBtn(_ sender: Any) {
        tapBtnCallbackFunc?(.close)
    }
    
    /// rightBtnタップ
    @IBAction func tapRightBtn(_ sender: Any) {
        tapBtnCallbackFunc?(.ok)
    }
}
