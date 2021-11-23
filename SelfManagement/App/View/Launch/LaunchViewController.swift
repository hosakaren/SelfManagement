//
//  LaunchViewController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

import UIKit

public class LaunchViewController: UIViewControllerBase {
    
    public override func viewId() -> ViewIdEnum! { .launch }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3秒後移動
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.moveScreen(.task_list)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension LaunchViewController: StoryBoardNameProtocol {
    public static var fileName: String { "LaunchView" }
    public static var title: String { "" }
}
