//
//  DatePickerViewViewController.swift
//  SelfManagement
//
//  Created by works on 2021/11/15.
//

import UIKit

class DatePickerViewController: UIViewController {

    public let storyBoardName: String = "DatePickerView"
    
    // datePicker
    @IBOutlet weak var yearDatePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!

    /// OKボタン押した時の戻り値
    public var callBackOkBtn: (() -> Void)?
   
    /// DatePickerViewのセットアップ
    public func setupDatePicker(
        dateValue: String = "",
        callBackOkBtn: (() -> Void)?
    ) {
        self.callBackOkBtn = callBackOkBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearDatePicker.preferredDatePickerStyle = .wheels
        yearDatePicker.setValue(UIColor.white, forKey: "textColor")
        yearDatePicker.setValue(false, forKey: "highlightsToday")
        
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.setValue(UIColor.white, forKey: "textColor")
        //timePicker.setValue(false, forKey: "highlightsToday")

        /// あとで初期値変更処理追記
        //datePicker.date = NSDate() as Date
        
        // viewタップジェスチャー登録
        let tapEntireViewGesture = UIGestureRecognizer(target: self, action: #selector(tapEntireView))
        self.view.superview?.addGestureRecognizer(tapEntireViewGesture)
    }
    /// okボタンタップ
    @IBAction func tapOkBtn(_ sender: Any) {
        callBackOkBtn?()
    }
    
    /// viewがタップされた場合閉じる
    @objc func tapEntireView() {
        super.dismiss(animated: false, completion: nil)
    }
}
