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
    let placeHolder = "Tap here to\n write a\ndescription..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let tabItem = UITabBar()
        tabItem.isHidden = true
        
        backBtnOutlet.addTarget(self, action: #selector(setBackAction(_:)), for: .touchUpInside)
        
        descriptionTextField.text = placeHolder
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
        
        if descriptionTextField.text == placeHolder{
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
            descriptionTextField.text = placeHolder
            descriptionTextField.textColor = UIColor.init(rgb: 0xB6C938)
            descriptionTextField.font = UIFont(name: "Montserrat", size: 23.2)
        }
    }
    
    
    @IBAction func actionOnPublic(_ sender: Any) {
        
       
        
        if let text = descriptionTextField.text , (!text.isEmpty){
            
           
            if (placeHolder !=  text){
                let loader = self.loader()
                let timestamp = NSDate().timeIntervalSince1970
                self.apiHandler.uploadVideo(text, self.videoURL, "\(timestamp)") {
                    
                    loader.dismiss(animated: true) {
                        
                        NotificationCenter.default.post(name: .updateVideoPlayer, object: nil)
                        
                        self.showAlertWithAction(messageToDisplay: "Video uploaded successfully") {
                            print("Called")
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                } failure: { err in
                    loader.dismiss(animated: true) {
                        
                        let alertController = UIAlertController(title: nil, message: err, preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "Done", style: .default) { (action:UIAlertAction!) in
                            alertController.dismiss(animated: true) {
                                self.navigationController?.popController()
                            }
                        }
                        alertController.addAction(OKAction)
                        
                        self.present(alertController, animated: true, completion:nil)
                    }
                }
                
            }else{
                self.showToast(message: "Please enter description", fontSize: 12)
                
            }
        }else{
            
            self.showToast(message: "Please enter description", fontSize: 12)
        }
      
    }
    
}


extension RecordVideoInfoController : StoryboardInitializable{
    
    static var storyboardName: UIStoryboard.Storyboard{return .home}
}
