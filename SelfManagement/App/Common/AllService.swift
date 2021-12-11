//
//  AllService.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//
import UIKit

public class AllService: NSObject {
    
    public static let shared = AllService()
    
    public override init() {}
    
    public func getDateFormatter(format: DateFormatterEnum) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        dateFormatter.dateFormat = format.value
        return dateFormatter
    }
}

public enum DateFormatterEnum {
    
    case yyyyMMdd
    
    var value: String {
        switch self {
        case .yyyyMMdd: return "yyyy年M月d日"
        }
    }
}
