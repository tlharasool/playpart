//
//  DescriptionTextField.swift
//  playpart
//
//  Created by Atif Habib on 06/10/2021.
//

import Foundation
import UIKit

class Descriptiontextfield: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var descriptionTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        descriptionTextField.text = "Tap here to\n write a\ndescription..."
        descriptionTextField.textColor = UIColor.init(rgb: 0xB6C938)
        descriptionTextField.font = UIFont(name: "Montserrat", size: 23.2)
        descriptionTextField.returnKeyType = .done
        descriptionTextField.delegate = self
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextField.text == "Tap here to\n write a\ndescription..." {
            descriptionTextField.text = ""
            descriptionTextField.textColor = UIColor.init(rgb: 0xB6C938)
            descriptionTextField.font = UIFont(name: "Montserrat", size: 18.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionTextField.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextField.text == "" {
            descriptionTextField.text = "Tap here to\n write a\ndescription..."
            descriptionTextField.textColor = UIColor.init(rgb: 0xB6C938)
            descriptionTextField.font = UIFont(name: "Montserrat", size: 23.2)
        }
    }
    
}
