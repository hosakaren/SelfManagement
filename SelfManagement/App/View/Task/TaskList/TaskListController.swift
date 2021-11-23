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
    
    fileprivate var displayCollectionList: [TaskScheme] = []
    
    /// 画面読み込み完了
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate、datasouce設定
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        let repo = TaskRepository()
        displayCollectionList = repo.findByIsFinished(false) ?? []
        
        noDataLabel.text = Localize.ja("no_data_label")
        noDataLabel.isHidden = !displayCollectionList.isEmpty
        
    }

    // セグメント変更
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        let repo = TaskRepository()
        displayCollectionList = repo.findByIsFinished(sender.selectedSegmentIndex == 1) ?? []
        noDataLabel.isHidden = !displayCollectionList.isEmpty
    }
    
    
    // 詳細(登録)画面遷移
    @IBAction func tapPlusBtn(_ sender: Any) {
        moveScreen(.task_detail)
    }
}

extension TaskListController: StoryBoardNameProtocol {
    public static var fileName: String { "TaskListView" }
    public static var title: String { Localize.ja("task_view_title") }
}

//extension TaskListController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
//        let displayCell = displayCollectionList[indexPath.row]
//        cell.setupCell(
//            isFinished: displayCell.isFinished,
//            content: displayCell.content,
//            date: displayCell.targetDate
//        )
//        return cell
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        displayCollectionList.count
//    }
//}
