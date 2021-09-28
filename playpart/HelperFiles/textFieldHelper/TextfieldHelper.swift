//
//  UITextFields.swift
//  playpart
//
//  Created by Atif Habib on 09/09/2021.
//

import Foundation
import UIKit

extension UITextField{
    func setDefaultTextFieldProperties(){
        let primaryColor = AppColor.primaryColor
        self.layer.borderColor = primaryColor.cgColor
        self.backgroundColor = UIColor.black
        self.layer.borderWidth = 1.0
        self.textColor = AppColor.primaryColor
        self.placeHolderColor = AppColor.primaryColor
    }
}

extension UIView{
    func setDefaulViewProperties(){
        let primaryColor = AppColor.primaryColor
        self.layer.borderColor = primaryColor.cgColor
        self.backgroundColor = UIColor.black
        self.layer.borderWidth = 1.0
    }
}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

