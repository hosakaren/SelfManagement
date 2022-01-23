//
//  ViewIdEnum.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/13.
//

import UIKit

public enum ViewIdEnum {
    
    case none
    /// 起動画面
    case launch
    /// bottom Tab
    //case bottom_tab
    /// タスク一覧
    case task_list
    /// タスク詳細
    case task_detail
    
    func getViewInfo() -> (
        fileName: String,
        title: String,
        isNavigationBar: Bool,
        isBackBtn: Bool,
        isBottomTabBar: Bool) {
            switch self {
//            case .bottom_tab:
//                return (
//                    fileName: UITabViewControllerBase.fileName,
//                    title: UITabViewControllerBase.title,
//                    isNavigationBar: false,
//                    isBackBtn: false,
//                    isBottomTabBar: true
//                )
            case .launch:
                return (
                    fileName: LaunchViewController.fileName,
                    title: LaunchViewController.title,
                    isNavigationBar: false,
                    isBackBtn: false,
                    isBottomTabBar: false
                )
            case .task_list:
                return (
                    fileName: TaskListController.fileName,
                    title: TaskListController.title,
                    isNavigationBar: true,
                    isBackBtn: false,
                    isBottomTabBar: true
                )
            case .task_detail:
                return (
                    fileName: TaskDetailController.fileName,
                    title: TaskDetailController.title,
                    isNavigationBar: true,
                    isBackBtn: true,
                    isBottomTabBar: false
                )
            default:
                return (
                    fileName: "",
                    title: "",
                    isNavigationBar: false,
                    isBackBtn: false,
                    isBottomTabBar: false
                )
            }
        }
    
}

