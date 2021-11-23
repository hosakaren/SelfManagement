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
    
    private var initialDate: Date?
    
    fileprivate let max_line_count: Int = 20
    fileprivate let max_word_count: Int = 200
    
    /// 画面読み込み完了
    public override func viewDidLoad() {
        super.viewDidLoad()
        // textView delegate設定
        textView.delegate = self
        
//        let tapGesture = UIGestureRecognizer(target: self, action: #selector(closeKeyBoard))
//        self.view.addGestureRecognizer(tapGesture)
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeKeyBoard))
//        swipeGesture.direction = .down
//        self.view.addGestureRecognizer(swipeGesture)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.backgroundColor = .white
    }
    
    /// 画面から離れる際の動作
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if textView.text.count > 0, initialDate != nil {
            createTask()
        }
    }
    
    /// 時間ボタンタップ
    @IBAction func tapDateBtn(_ sender: Any) {
        let nextView = StoryBoardInstance.singleton.instanceVC(fileName: DatePickerViewController.fileName) as! DatePickerViewController
        nextView.initialDate = initialDate
        nextView.callbackFunc = { date in
            self.initialDate = date
            let dateFormatter = AllService.singleton.getDateFormatter(format: .yyyyMMdd)
            self.dateBtn.setTitle(dateFormatter.string(from: date), for: .normal)
        }
        self.present(nextView, animated: true)
    }
    
    /// 保存ボタンタップ
    @IBAction func tapSaveBtn(_ sender: Any) {
        let dialog = StoryBoardInstance.singleton.instanceVC(fileName: MessageDialogViewController.fileName) as! MessageDialogViewController
        if textView.text.count == 0 || initialDate == nil{
            dialog.setupDialog(
                message: Localize.ja("no_content_task"),
                btnType: .close,
                tapBtnCallbackFunc: { _ in
                    // ダイアログdismiss
                    self.dismiss(animated: true)
                    // detail-dismiss
                    self.dismiss(animated: true)
                }
            )
        } else {
            dialog.setupDialog(
                message: Localize.ja("is_save_task"),
                btnType: .save_and_cancel,
                tapBtnCallbackFunc: { type in
                    if type == .ok {
                        self.createTask()
                        // ダイアログdismiss
                        self.dismiss(animated: true)
                        // detail-dismiss
                        self.dismiss(animated: true)
                    } else {
                        self.dismiss(animated: true)
                    }
                })
        }
        
        self.present(dialog, animated: true)
    }
    
    /// キーボード閉じる
    @objc func closeKeyBoard() {
        self.textView.endEditing(true)
    }
    
    private func createTask() {
        let repo = TaskRepository()
        if let id = TaskViewSharing.singleton.id {
            let scheme = repo.findOne(id)
            scheme?.content = textView.text
            scheme?.targetDate = initialDate
            repo.save(scheme!)
        } else {
            let scheme = TaskScheme()
            scheme.content = textView.text
            scheme.targetDate = initialDate
            repo.save(scheme)
        }
    }
}

extension TaskDetailController: StoryBoardNameProtocol {
    public static var fileName: String { "TaskDetailView" }
    public static var title: String { Localize.ja("task_view_title") }
}

extension TaskDetailController: UITextViewDelegate {
    
    /// textViewの制限
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputLines: Int = textView.text.components(separatedBy: .newlines).count
        let newLines: Int = text.components(separatedBy: .newlines).count
        let lineRestricsion: Bool = inputLines + newLines <= max_line_count
        let wordRestriction: Bool = textView.text.count + text.count <= max_word_count
        return lineRestricsion && wordRestriction
    }
}
