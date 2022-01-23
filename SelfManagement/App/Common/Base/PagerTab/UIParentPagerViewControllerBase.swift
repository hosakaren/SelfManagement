//
//  UIParentPagerViewControllerBase.swift
//  SelfManagement
//
//  Created by hosakaren on 2022/01/22.
//

import UIKit

open class UIParentPagerViewControllerBase: UIViewControllerBase {

    // TODO: - ViewのIBOutlet
    // scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    /// Stack View
    @IBOutlet weak var stackView: UIStackView!
    /// PagerTab用のCollectionView
    @IBOutlet weak var pagerTabCollectionView: UICollectionView!
    /// PagerTabView
    @IBOutlet weak var pagerContainerView: UIView!
    /// PagerTab用のCollectionView(FlowLayout)
    @IBOutlet weak var pagerTabCollectionViewFL: UICollectionViewFlowLayout!
    
    // TODO: - IBOutlet以外のメンバ
    /// PagerTabの上にViewが存在するか(true: 存在する、false: 存在しない)
    fileprivate var isExistInitialContainerView: Bool = false
    /// PagerTabのリスト
    fileprivate var pagerTabList: [(viewController: UIViewControllerBase, title: String)] = []
    /// Cellの名前
    fileprivate let pagerTabCollectionViewCellName: String = String(describing: PagerTabViewCell.self)
    /// 追加するUIVIew
    fileprivate var insertView: UIView? = nil
    /// pager view controller
    fileprivate var childPagerVC: UIChildPagerViewControllerBase!

    // TODO: - ライフサイクル
    public override func viewDidLoad() {
        super.viewDidLoad()

        // insertViewを表示
        //        if let insertView = insertView {
        //
        //        }

        // collection_viewのdatasource、delegate設定
        pagerTabCollectionView.dataSource = self
        pagerTabCollectionView.delegate = self
        
        // サイズは適当
        pagerTabCollectionViewFL.estimatedItemSize = CGSize(width: 50, height: 20)
        pagerTabCollectionViewFL.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        // collection_viewにcellを登録
        let bundle = Bundle(for: UIParentPagerViewControllerBase.self)
        let cellNib = UINib(nibName: String(describing: PagerTabViewCell.self), bundle: bundle)
        pagerTabCollectionView.register(
            cellNib,
            forCellWithReuseIdentifier: pagerTabCollectionViewCellName
        )

        // PagerChildViewのSetup
        self.addChild(self.childPagerVC)
        self.childPagerVC.view.frame = pagerContainerView.bounds
        self.pagerContainerView.addSubview(self.childPagerVC.view)
        self.childPagerVC.didMove(toParent: self)
    }


    /// PagerViewControllerを表示するためのメソッド
    public func setupChildPagerViewController(childPagerVC: UIChildPagerViewControllerBase) {
        self.childPagerVC = childPagerVC
        self.pagerTabList = self.childPagerVC.viewControllerList
    }

    public func insertView(insertView: UIView? = nil, pagerTabList: [UIViewControllerBase]) {
        self.insertView = insertView
        //self.pagerTabList = pagerTabList
    }

}

// MARK: - UICollectionViewDelegate
extension UIParentPagerViewControllerBase: UICollectionViewDelegate {
    /// cellの生成
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: pagerTabCollectionViewCellName,
            for: indexPath
        ) as! PagerTabViewCell
        cell.setupCell(
            /// Cellのボタンをタップしたときの挙動
            tapCellClosure: nil,
            //            tapCellClosure: { [weak self] in
            ////                guard let self = self else { return }
            //
            //            },
            title: pagerTabList[indexPath.row].title
        )
        return cell
    }

}

// MARK: - UICollectionViewDataSource
extension UIParentPagerViewControllerBase: UICollectionViewDataSource {
    // cellの数返却
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagerTabList.count
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension UIParentPagerViewControllerBase: UICollectionViewDelegateFlowLayout {

    /// cell間の間隔調整
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    /// cellの大きさ調整
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count: CGFloat = CGFloat(pagerTabList.count)
        let height: CGFloat = pagerTabCollectionView.bounds.height
        var width: CGFloat
        let screenWidth = UIScreen.main.bounds.width
        // tab数が5以下のときはcellの大きさはtab数で割った値
        // tab数が5より大きいときはcellの大きさは5で割った値
        if count <= 5 {
            width = screenWidth / count
        } else {
            width = screenWidth / CGFloat(5)
        }
        print("count===\(count)")
        print("screenWidth===\(screenWidth)")
        print("width===\(width)")
        return CGSize(width: width, height: height)
    }
}
