//
//  ExtensionBundle.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/20.
//

import UIKit

public extension Bundle {
    
    static var lib: Bundle {
        class dummyClass {}
        return Bundle(for: type(of: dummyClass()))
    }
}
