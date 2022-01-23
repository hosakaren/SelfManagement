//
//  TaskListCell.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/15.
//

import UIKit

@IBDesignable class TaskListCell: UICollectionViewCell {
    
    /// ボタン
    @IBOutlet weak var selectBtn: UIButton!
    /// タスクコンテンツ
    @IBOutlet weak var content: UILabel!
    /// 期日
    @IBOutlet weak var date: UILabel!
    
    
    public var tapCellCallbackFunc: (() -> Void)?
    public var tapBtnCallbackFunc: ((_ isFinished: Bool) -> Void)?
    
    private var isFinished: Bool = false
    private let dateFormatter = AllService.shared.getDateFormatter(format: .yyyyMMdd)
    private var isDeleteMode: Bool = false
    
    public var displayView: UICollectionViewCell?
    
    private var squareImage: UIImage? = UIImage(systemName: "square")
    private var checkMarkImage: UIImage? = UIImage(systemName: "checkmark.square")
    private var trashImage: UIImage? = UIImage(systemName: "trash.fill")
    
    public override func prepareForReuse() {
        super.prepareForReuse()
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
        let view = nib.instantiate(withOwner: self, options: nil).first as! UICollectionViewCell
        // ビューの追加
        addSubview(view)
        
        displayView = view
        
        content.sizeToFit()
        
        squareImage?.withTintColor(UIColor.black)
        checkMarkImage?.withTintColor(UIColor.black)
        trashImage?.withTintColor(UIColor.black)
        
        selectBtn.setTitle("", for: .normal)
        
        let width = selectBtn.bounds.width
        let height = selectBtn.bounds.height
        squareImage = squareImage?.resize(image: squareImage!, width: width, height: height)
        checkMarkImage = checkMarkImage?.resize(image: checkMarkImage!, width: width, height: height)
        trashImage = trashImage?.resize(image: trashImage!, width: width, height: height)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        displayView?.addGestureRecognizer(tapGesture)
    }
    
    public func setupCell(
        isFinished: Bool = false,
        content: String,
        date: Date,
        isDeleteMode: Bool = false,
        tapBtnCallbackFunc: ((_ isFinished: Bool) -> Void)?,
        tapCellCallbackFunc: (() -> Void)?
    ) {
        self.isFinished = isFinished
        self.content.text = content
        self.date.text = dateFormatter.string(from: date)
        self.isDeleteMode = isDeleteMode
        self.tapBtnCallbackFunc = tapBtnCallbackFunc
        self.tapCellCallbackFunc = tapCellCallbackFunc
        
        /// 期日チェック入れる
        if date < Date() && !isFinished {
            self.date.textColor = UIColor.red
        } else {
            self.date.textColor = UIColor.black
        }
        
        setupSelectImage(isFinished: isFinished, isDeleteMode: isDeleteMode)
    }
    
    /// チェックマークエリアタップ
    @IBAction func tapSelectBtn(_ sender: Any) {
        if isDeleteMode {
            /// 削除しますかポップアップ表示
            
            ///Yes delete No stay
            
        } else {
            self.isFinished = !self.isFinished
            setupSelectImage(isFinished: self.isFinished, isDeleteMode: false)
            tapBtnCallbackFunc?(isFinished)
        }
    }
    
    public func setupSelectImage(isFinished: Bool, isDeleteMode: Bool) {
        self.isFinished = isFinished
        if isDeleteMode {
            selectBtn.setImage(trashImage, for: .normal)
        } else {
            if isFinished {
                selectBtn.setImage(checkMarkImage, for: .normal)
            } else {
                selectBtn.setImage(squareImage, for: .normal)
            }
        }
    }
    
    @objc func tapCell() {
        tapCellCallbackFunc?()
    }
    
}
