//
//  FooterBtnEnum.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

public enum FooterBtnEnum {
    // 閉じる
    case close
    // 保存
    case save
    // 保存 キャンセル
    case save_and_cancel
    // 「はい」、「いいえ」
    case yes_and_no
    
    var btnLabel: [String] {
        switch self {
        case .close: return [Localize.ja("close")]
        case .save: return [Localize.ja("save")]
        case .save_and_cancel: return [Localize.ja("cancel"), Localize.ja("save")]
        case .yes_and_no: return [Localize.ja("no"), Localize.ja("yes")]
        }
    }
    
    var isCloseTapBackground: Bool {
        switch self {
        case .close: return true
        default: return false
        }
    }
}


public enum ReturnFooterBtnEnum {
    case close
    case ok
}
