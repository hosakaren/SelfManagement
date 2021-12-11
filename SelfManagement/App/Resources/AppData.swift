//
//  AppData.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/12/02.
//

import UIKit

public class AppData: NSObject {
    
    public static let shared = AppData()
    
    public override init() {}

    let taskRepo = TaskRepository()
}
