//
//  StoryBoardInstance.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/21.
//

import UIKit

public protocol StoryBoardNameProtocol {
    
    static var fileName: String { get }
    static var title: String { get }
}


public class StoryBoardInstance: NSObject {
    
    private override init() {}
    public static let singleton = StoryBoardInstance()
    
    public func instanceVC(fileName: String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: fileName, bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
