//
//  TaskListController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit

open class TaskListController: UIViewControllerBase {
    
    public override func viewId() -> ViewIdEnum! { ViewIdEnum.task_list }
        
    /// 画面読み込み完了
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    // セグメント変更
    @IBAction func changeTaskSegment(_ sender: Any) {
        
    }
    
    // 詳細(登録)画面遷移
    @IBAction func tapPlusBtn(_ sender: Any) {
        moveScreen(.task_detail)
    }
}
