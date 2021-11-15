//
//  TaskDetailController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/14.
//

import UIKit

public class TaskDetailController: UIViewControllerBase {
    
    public override func viewId() -> ViewIdEnum! { ViewIdEnum.task_detail }
    
    /// テキストビュー
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var dateBtn: UIButton!
    /// 画面読み込み完了
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 時間ボタンタップ
    @IBAction func tapDateBtn(_ sender: Any) {
        let datePicker = DatePickerViewController()
        datePicker.view.frame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
        self.view.addSubview(datePicker.view)
    }
}
