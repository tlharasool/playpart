//
//  DescriptionTextField.swift
//  playpart
//
//  Created by Atif Habib on 06/10/2021.
//

import Foundation
import UIKit

class RecordVideoInfoController : UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var videoURL : URL!
    let apiHandler = API_Handler.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let tabItem = UITabBar()
        tabItem.isHidden = true
        
        backBtnOutlet.addTarget(self, action: #selector(setBackAction(_:)), for: .touchUpInside)
        
        descriptionTextField.text = "Tap here to\n write a\ndescription..."
        descriptionTextField.textColor = UIColor.init(rgb: 0xB6C938)
        descriptionTextField.font = UIFont(name: "Montserrat", size: 23.2)
        descriptionTextField.returnKeyType = .done
        descriptionTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hideBar()
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
    
    
    @IBAction func actionOnPublic(_ sender: Any) {
        
        let loader = self.loader()
        
        if let text = descriptionTextField.text , !text.isEmpty{
            
           
                let timestamp = NSDate().timeIntervalSince1970
                self.apiHandler.uploadVideo(text, self.videoURL, "\(timestamp)") {
                    
                    loader.dismiss(animated: true) {
                        
                        self.showAlertWithAction(messageToDisplay: "Video uploaded successfully") {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                } failure: { err in
                    loader.dismiss(animated: true) {
                        
                        self.showAlertWithAction(messageToDisplay: err) {
                            self.navigationController?.popController()
                        }
                    }
                }
                
            
        }else{
            self.showAlertWithAction(messageToDisplay: "Description is empty") {}
        }
      
    }
    
}


extension RecordVideoInfoController : StoryboardInitializable{
    
    static var storyboardName: UIStoryboard.Storyboard{return .home}
}
