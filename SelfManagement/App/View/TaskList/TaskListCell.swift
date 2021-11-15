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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // cellタップ
        let tapView = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        self.contentView.addGestureRecognizer(tapView)
        
        // チェックマークタップ
        let tapCheckMarkView = UITapGestureRecognizer(target: self, action: #selector(tapCheckMarkArea))
        self.ckeckMarkArea.addGestureRecognizer(tapCheckMarkView)
    }
    
    public func setupCell(
        isFinished: Bool = false,
        content: String,
        date: String
    ) {
        self.isFinished = isFinished
        setupCheckMark(isFinished: isFinished)
        self.content.text = content
        self.date.text = date
        
        /// 期日チェック入れる
        
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
    /// セルタップ
    @objc func tapCell() {
        
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
