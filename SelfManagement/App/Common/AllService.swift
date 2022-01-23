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
    
    public func getStringNumberOfLine(_ keyword: String) -> Int {
        var count: Int = 0
        print(keyword)
        var nextrange = keyword.startIndex ..< keyword.endIndex
        while let range = keyword.range(of: "/n", options: .caseInsensitive, range: nextrange) {
            count += 1
            nextrange = range.upperBound ..< keyword.endIndex
        }
        return count
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
