//
//  Localize.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/14.
//

import UIKit

public class Localize {
    
    public static func ja(_ key: String) -> String {
        NSLocalizedString(key, tableName: "ja", comment: "")
    }
    
    public static func filePath(_ key: String) -> String {
        NSLocalizedString(key, tableName: "file_name", comment: "")
    }
}

public class FileAdmin {
    public static func image(_ imageName: String) -> UIImage? {
        UIImage(systemName: Localize.filePath(imageName))
    }
}
