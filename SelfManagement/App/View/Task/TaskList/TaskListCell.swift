//
//  TaskListCell.swift
//  SelfManagement
//
//  Created by works on 2021/11/15.
//

import UIKit

class TaskListCell: UICollectionViewCell {

    /// チェックマークエリア
    @IBOutlet weak var ckeckMarkArea: UIView!
    /// チェックマーク
    @IBOutlet weak var checkMarkImage: UIImageView!
    /// noチェックマーク
    @IBOutlet weak var noCheckMarkImage: UIImageView!
    /// タスクコンテンツ
    @IBOutlet weak var content: UILabel!
    /// 期日
    @IBOutlet weak var date: UILabel!
    
    
    public var callBackTapCheckMarkArea: (() -> Void)?
    public var callBackTapCellArea: (() -> Void)?
    
    private var isFinished: Bool = false
    private let dateFormatter = AllService.singleton.getDateFormatter(format: .yyyyMMdd)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // チェックマークタップ
        let tapCheckMarkView = UITapGestureRecognizer(target: self, action: #selector(tapCheckMarkArea))
        self.ckeckMarkArea.addGestureRecognizer(tapCheckMarkView)
    }
    
    public func setupCell(
        isFinished: Bool = false,
        content: String,
        date: Date
    ) {
        self.isFinished = isFinished
        setupCheckMark(isFinished: isFinished)
        self.content.text = content
        self.date.text = dateFormatter.string(from: date)
        
        /// 期日チェック入れる
        if date < Date() && !isFinished {
            self.date.textColor = UIColor.red
        } else {
            self.date.textColor = UIColor.white
        }
        
        setupCheckMark(isFinished: isFinished)
    }
    
    /// チェックマークエリアタップ
    @objc func tapCheckMarkArea() {
        switch self.isFinished {
        case true:
            checkMarkImage.isHidden = false
            noCheckMarkImage.isHidden = true
        default:
            checkMarkImage.isHidden = false
            noCheckMarkImage.isHidden = true
            
            /// 完了しましたポップアップ表示
        }
    }
    
    private func setupCheckMark(isFinished: Bool) {
        switch isFinished {
        case true:
            checkMarkImage.isHidden = false
            noCheckMarkImage.isHidden = true
        default:
            checkMarkImage.isHidden = false
            noCheckMarkImage.isHidden = true
        }
    }
    
}
