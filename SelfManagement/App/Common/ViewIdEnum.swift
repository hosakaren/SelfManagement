//
//  ViewIdEnum.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit

public enum ViewIdEnum {
    
    /// タスク一覧
    case task_list
    /// タスク詳細
    case task_detail
    
    func getViewInfo() -> (
        view: String,
        title: String,
        isNavigationBar: Bool, isBackBtn: Bool,
        isBottomTabBar: Bool) {
            switch self {
            case .task_list:
                return (view: "TaskListView", title: Localize.ja("task_view_title"), isNavigationBar: true, isBackBtn: false, isBottomTabBar: true)
            case .task_detail:
                return (view: "TaskDetailView", title: Localize.ja("task_view_title"), isNavigationBar: true, isBackBtn: true, isBottomTabBar: true)
            }
    }
}
