//
//  TaskListController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit


open class TaskListController: UIViewControllerBase {
    
    public override func viewId() -> ViewIdEnum { ViewIdEnum.task_list }
        
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    
    fileprivate var displayCollectionList: [TaskScheme] = []
    
    private var isSelectedComplete: Bool = false
    
    let repo = AppData.shared.taskRepo
    
    /// 画面読み込み完了
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate、datasouce設定
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TaskListCell.self, forCellWithReuseIdentifier: "TaskListCell")
        
        displayCollectionList = repo.findByIsFinished(isSelectedComplete) ?? []
        
        noDataLabel.text = Localize.ja("no_data_label")
        noDataLabel.isHidden = !displayCollectionList.isEmpty
        
        segmentControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)

        let rightSwipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeView)
        )
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeView)
        )
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectBtn.isEnabled = false
        selectBtn.customView?.isHidden = true
        
        displayCollectionList = repo.findByIsFinished(isSelectedComplete) ?? []
        collectionView.reloadData()
    }

    // セグメント変更
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        isSelectedComplete = sender.selectedSegmentIndex == 1
        displayCollectionList = repo.findByIsFinished(isSelectedComplete) ?? []
        noDataLabel.isHidden = !displayCollectionList.isEmpty
        collectionView.reloadData()
    }
    
    
    // 詳細(登録)画面遷移
    @IBAction func tapPlusBtn(_ sender: Any) {
        
        let parentStoryboard: UIStoryboard = UIStoryboard(name: "UIParentPagerView", bundle: nil)
        let parentVC = parentStoryboard.instantiateInitialViewController() as! UIParentPagerViewControllerBase
        
        
        let granChildStoryboard: UIStoryboard = UIStoryboard(name: "TaskListView", bundle: nil)
        let grandChildVC = granChildStoryboard.instantiateInitialViewController() as! TaskListController
        grandChildVC.modalPresentationStyle = .fullScreen
        
        let childVC = UIChildPagerViewControllerBase()
        childVC.setupChildVC(viewControllerList: [(viewController: grandChildVC, title: "保坂")])
        
//        childVC.setupChildVC(viewControllerList: [grandChildVC])
        parentVC.setupChildPagerViewController(childPagerVC: childVC)
        navigationController?.pushViewController(parentVC, animated: true)
        
//        TaskViewSharing.shared.id = nil
//        TaskViewSharing.shared.content = nil
//        TaskViewSharing.shared.targetDate = nil
//        moveScreen(.task_detail)
    }
    
    @IBAction func tapSelectBtn(_ sender: Any) {
        
    }
    
    @objc func swipeView(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            if !isSelectedComplete {
                segmentControl.selectedSegmentIndex = 1
                changeSegmentedControl(segmentControl)
            }
        case .right:
            if isSelectedComplete {
                segmentControl.selectedSegmentIndex = 0
                changeSegmentedControl(segmentControl)
            }
        default: break
        }

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
            tapBtnCallbackFunc: { [weak self] isFinished in
                guard let self = self else { return }
                let messageDialog = StoryBoardInstance.shared.instanceVC(fileName: MessageDialogViewController.fileName) as! MessageDialogViewController
                let message: String = isFinished ? Localize.ja("is_task_complete_finishing") : Localize.ja("is_task_complete_finishing_yet")
                messageDialog.setupDialog(
                    message: message,
                    btnType: .yes_and_no,
                    tapBtnCallbackFunc: { returnFooterBtn in
                        switch returnFooterBtn {
                        case .ok:
                            self.repo.updateIsFinished(displayCell, isFinished: isFinished)
                            self.displayCollectionList = self.repo.findByIsFinished(self.isSelectedComplete) ?? []
                            self.dismiss(animated: true)
                            collectionView.reloadData()
                        default:
                            cell.setupSelectImage(isFinished: displayCell.isFinished, isDeleteMode: false)
                            self.dismiss(animated: true)
                        }
                    }
                )
                self.present(messageDialog, animated: true)
            },
            tapCellCallbackFunc: { [weak self] in
                guard let self = self else { return }
                let id = displayCell.id
                let taskScheme = self.repo.findOne(id)
                TaskViewSharing.shared.id = taskScheme?.id
                TaskViewSharing.shared.content = taskScheme?.content
                TaskViewSharing.shared.targetDate = taskScheme?.targetDate
                self.moveScreen(.task_detail)
            }
        )
        return cell
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
