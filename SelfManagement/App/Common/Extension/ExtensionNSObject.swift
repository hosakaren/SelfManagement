//
//  ExtensionNSObject.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/20.
//

import UIKit

public protocol ClassNameProtocol {
    
    static var className: String { get }
    
}

public extension ClassNameProtocol {
    static var className: String {
        String.init(describing: self)
    }
}

extension NSObject: ClassNameProtocol {}

public extension NSObject{
    
    var className: String {Self.className}
    
}
