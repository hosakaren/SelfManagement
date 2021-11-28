//
//  ExtensionUIImage.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/27.
//

import UIKit

extension UIImage {
    
    func resize(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
            
        // widthからアスペクト比を元にリサイズ後のサイズを取得
        let resizedSize = CGSize(width: width, height: height)
        
        // リサイズ後のUIImageを生成して返却
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    
}
