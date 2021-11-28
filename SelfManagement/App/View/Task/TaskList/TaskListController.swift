//
//  TaskListController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit


open class TaskListController: UIViewControllerBase {
    
    public override func viewId() -> ViewIdEnum! { ViewIdEnum.task_list }
        
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    
    fileprivate var displayCollectionList: [TaskScheme] = []
    
    private var isSelectedComplete: Bool = false
    
    /// 画面読み込み完了
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate、datasouce設定
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TaskListCell.self, forCellWithReuseIdentifier: "TaskListCell")
        
        let repo = TaskRepository()
        displayCollectionList = repo.findByIsFinished(isSelectedComplete) ?? []
        
        noDataLabel.text = Localize.ja("no_data_label")
        noDataLabel.isHidden = !displayCollectionList.isEmpty
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectBtn.isEnabled = false
        selectBtn.customView?.isHidden = true
        
        let repo = TaskRepository()
        displayCollectionList = repo.findByIsFinished(isSelectedComplete) ?? []
        collectionView.reloadData()
    }

    // セグメント変更
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        let repo = TaskRepository()
        isSelectedComplete = sender.selectedSegmentIndex == 1
        displayCollectionList = repo.findByIsFinished(isSelectedComplete) ?? []
        noDataLabel.isHidden = !displayCollectionList.isEmpty
        collectionView.reloadData()
    }
    
    
    // 詳細(登録)画面遷移
    @IBAction func tapPlusBtn(_ sender: Any) {
        TaskViewSharing.singleton.id = nil
        TaskViewSharing.singleton.content = nil
        TaskViewSharing.singleton.targetDate = nil
        moveScreen(.task_detail)
    }
    
    @IBAction func tapSelectBtn(_ sender: Any) {
        
    }
}

extension TaskListController: StoryBoardNameProtocol {
    public static var fileName: String { "TaskListView" }
    public static var title: String { Localize.ja("task_view_title") }
}

extension TaskListController: UICollectionViewDelegate {

    /// collectionview読み込み
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        let displayCell = displayCollectionList[indexPath.row]
        cell.setupCell(
            isFinished: displayCell.isFinished,
            content: displayCell.content,
            date: displayCell.targetDate,
            isDeleteMode: false,
            tapBtnCallbackFunc: { isFinished in
                let messageDialog = StoryBoardInstance.singleton.instanceVC(fileName: MessageDialogViewController.fileName) as! MessageDialogViewController
                let message: String = isFinished ? Localize.ja("is_task_complete_finishing") : Localize.ja("is_task_complete_finishing_yet")
                messageDialog.setupDialog(
                    message: message,
                    btnType: .yes_and_no,
                    tapBtnCallbackFunc: { returnFooterBtn in
                        switch returnFooterBtn {
                        case .ok:
                            let repo = TaskRepository()
                            repo.updateIsFinished(displayCell, isFinished: isFinished)
                            self.displayCollectionList = repo.findByIsFinished(self.isSelectedComplete) ?? []
                            self.dismiss(animated: true)
                            collectionView.reloadData()
                        default:
                            cell.setupSelectImage(isFinished: displayCell.isFinished, isDeleteMode: false)
                            self.dismiss(animated: true)
                        }
                    }
                )
                self.present(messageDialog, animated: true)
            }
        )
        return cell
    }
    
    /// セルタップ
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let diplayCell = displayCollectionList[indexPath.row]
        let id = diplayCell.id
        let repo = TaskRepository()
        let taskScheme = repo.findOne(id)
        TaskViewSharing.singleton.id = taskScheme?.id
        TaskViewSharing.singleton.content = taskScheme?.content
        TaskViewSharing.singleton.targetDate = taskScheme?.targetDate
        self.moveScreen(.task_detail)
    }
    
}

extension TaskListController: UICollectionViewDataSource {
    /// collectionviewの数
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayCollectionList.count
    }
}

extension TaskListController: UICollectionViewDelegateFlowLayout {
    
    /// cell の大きさ指定
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        let lineCount: Int = cell.content.numberOfLines
        let textHeight: CGFloat = cell.content.font.lineHeight

        var height: CGFloat = textHeight * 5
        if lineCount > 5 {
            height = CGFloat(lineCount) * textHeight
        }
        return CGSize(width: width, height: height)
    }
    
    /// cellのmargin指定
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
}
