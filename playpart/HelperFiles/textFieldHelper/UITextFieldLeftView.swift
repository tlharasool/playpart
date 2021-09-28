//
//  leftView.swift
//  playpart
//
//  Created by Atif Habib on 10/09/2021.
//

import UIKit
import Foundation
class leftView: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

            override open func textRect(forBounds bounds: CGRect) -> CGRect {
                return bounds.inset(by: padding)
            }

            override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
                return bounds.inset(by: padding)
            }

            override open func editingRect(forBounds bounds: CGRect) -> CGRect {
                return bounds.inset(by: padding)
            }

}
