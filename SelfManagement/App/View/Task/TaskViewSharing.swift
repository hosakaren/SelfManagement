//
//  TaskViewSharing.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

import UIKit

public class TaskViewSharing: NSObject {
    
    public static let shared = TaskViewSharing()
    
    public override init() {}
    
    var id: String?
    var content: String?
    var targetDate: Date?
}
