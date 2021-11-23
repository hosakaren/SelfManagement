//
//  DatePickerViewController.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/20.
//

import UIKit

public class DatePickerViewController: UIDialogViewControllerBase {
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var footerBtn: FooterBtnView!
    
    public var callbackFunc: ((Date)-> Void)?
    
    public var initialDate: Date?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .wheels
        
        if let date = self.initialDate {
            datePicker.date = date
        }
        // datePickerのテキストカラーを設定
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        footerBtn.setupBtn(
            btnType: .save,
            tapBtnCallbackFunc: { _ in
                self.callbackFunc?(self.datePicker.date)
                self.dismiss(animated: true)
            }
        )
    }
}

extension DatePickerViewController: StoryBoardNameProtocol {
    public static var fileName: String { "DatePickerView" }
    public static var title: String { "" }
}

