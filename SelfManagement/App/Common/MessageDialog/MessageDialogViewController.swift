//
//  MessageDialogViewController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

import UIKit

public class MessageDialogViewController: UIDialogViewControllerBase {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var footerBtn: FooterBtnView!
    
    public var message: String!
    public var btnType: FooterBtnEnum!
    public var tapBtnCallbackFunc: ((ReturnFooterBtnEnum) -> Void)?
    
    public func setupDialog(
        message: String,
        btnType: FooterBtnEnum,
        tapBtnCallbackFunc: ((ReturnFooterBtnEnum) -> Void)?
    ) {
        self.message = message
        self.btnType = btnType
        self.tapBtnCallbackFunc = tapBtnCallbackFunc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text = self.message
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        footerBtn.setupBtn(
            btnType: btnType,
            tapBtnCallbackFunc: tapBtnCallbackFunc
        )
    }
}

extension MessageDialogViewController: StoryBoardNameProtocol {
    public static var fileName: String { "MessageDialogView" }
    public static var title: String { "" }
}
