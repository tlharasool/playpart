//
//  ViewController.swift
//  playpart
//
//  Created by Atif Habib on 09/09/2021.
//

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController{
    
    @IBOutlet weak var insertUsernameTxtFld: UITextField!
    @IBOutlet weak var insertNameTxtFld: UITextField!
    @IBOutlet weak var passwordFieldTxtFld: UITextField!
    @IBOutlet weak var repeatPasswordTxtFld: UITextField!
    @IBOutlet weak var insertView : UIView!
    @IBOutlet weak var privacyLbl: UILabel!
    // let leftViewspace = leftView()
    
    let privacy_terms_text = "By tapping “Sign up”, you agree to our Terms of service and acknowledge that you have read our Privacy Policy and community guidelines"

    let apiHandler = API_Handler.shared
    private let primaryColor = AppColor.primaryColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        configureTapGesture()
        setPrivacy_TermsLbl()
    }
    
    func popUpSreenAfterSignUp(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "UISelectionViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setTxtFldProperties()
    }
}
extension ViewController{
    
    @IBAction func actionOnSignUp(_ sender: Any) {
        view.endEditing(true)
        checkEntities()
       // performSegue(withIdentifier: "UISelectionViewController", sender: self)
        //self.navigationController?.pop(animated: true)
        //serverSide()
        //let loader = self.loader()
        
    }
    @IBAction func alreadyHaveAnAccount(_ sender: Any) {
        /*let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(identifier: "logIn")
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)*/
        
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension ViewController{
    
    func setPrivacy_TermsLbl(){
        
        privacyLbl.text = privacy_terms_text
        let underlineAttriString = NSMutableAttributedString(string: privacy_terms_text)
        let range1 = (privacy_terms_text as NSString).range(of: "Terms of service")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
       // underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont., range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.primaryColor, range: range1)
        
        
        let range2 = (privacy_terms_text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
       // underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont., range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.primaryColor, range: range2)
        
        let range3 = (privacy_terms_text as NSString).range(of: "community guidelines")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range3)
       // underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont., range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.primaryColor, range: range3)
        
        privacyLbl.attributedText = underlineAttriString
        privacyLbl.isUserInteractionEnabled = true
        privacyLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (privacy_terms_text as NSString).range(of: "Terms of service")
        // comment for now
        let privacyRange = (privacy_terms_text as NSString).range(of: "Privacy Policy")
        let community_guidelines =  (privacy_terms_text as NSString).range(of: "community guidelines")
        
        if gesture.didTapAttributedTextInLabel(label: privacyLbl, inRange: termsRange) {
            print("Tapped terms")
            let url = "https://playpart.xyz/terms-of-service"
            openPrivacy_Terms(url: url)
           
        } else if gesture.didTapAttributedTextInLabel(label: privacyLbl, inRange: privacyRange) {
            print("Tapped privacy")
            let url =  "https://playpart.xyz/privacy-policy"
            openPrivacy_Terms(url: url)
          
        } else if gesture.didTapAttributedTextInLabel(label: privacyLbl, inRange: community_guidelines) {
            print("community_guidelines")
            let url =  "https://playpart.xyz/community-guidelines"
            openPrivacy_Terms(url: url)
           
        }else{
            print("Tapped none")
        }
    }
    
    
    func openPrivacy_Terms(url : String){
        
        let vc = PolicyViewController.instantiateViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.url = url
        self.present(nav, animated: true, completion: nil)
        
    }
    
}


extension ViewController{
    
    func serverSide(){
        let loader =  self.loader()
        let params = ["email" : insertNameTxtFld.text,"password" : passwordFieldTxtFld.text,"password_confirmation" : repeatPasswordTxtFld.text,"username" : insertUsernameTxtFld.text]
        apiHandler.registerUser(parameters: params, success: {msg in
            self.stopLoader(loader: loader) {
                DispatchQueue.main.async {
                    print("Enter Sucessfully")
                    self.popUpSreenAfterSignUp()
                    print(msg)
                }
                
            }
     
        }, failure: {msg in
            
            
            self.stopLoader(loader: loader) {
            
                DispatchQueue.main.async {
                    print("Already have an account")
                    let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
                    self.present(alert, animated: true)
                    print("error in main Queu")
                    print(msg)
                }
            }
        })

    }
}
extension ViewController{
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handelTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handelTap(){
        view.endEditing(true)
    }
}
extension ViewController{
    private func configureTextFields(){
        insertNameTxtFld.delegate = self
        passwordFieldTxtFld.delegate = self
        repeatPasswordTxtFld.delegate = self
    }
}

extension ViewController{
    func signUp(){
        
    }
    func checkEntities(){
        
        if insertNameTxtFld.text == "" || passwordFieldTxtFld.text == "" || repeatPasswordTxtFld.text == "" || insertUsernameTxtFld.text == ""{
            let alert = UIAlertController(title: "Please fill all the manadatory fields.", message: "Please enter all the values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
            present(alert, animated: true)
        }
        else{
            //MARK:- Regex + Password + Repead password
            if emailIsValid() == false{
                let alert = UIAlertController(title: "Please fill all the manadatory fields.", message: "Please enter all the values.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
                present(alert, animated: true)
            }
            else if checkPasswordLength() == false{
                let alert = UIAlertController(title: "Enter password upto 8 length", message: "Enter password upto 8 length.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
                present(alert, animated: true)
            }
            else  if comparePasswordAndRepeatPassword() == false{
                let alert = UIAlertController(title: "Password Does not match", message: "Password and repeat password must be same.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
                present(alert, animated: true)
            }
            else{
               
                self.serverSide()
                
            }
           
        }
        
    }
}

extension ViewController{
    func emailIsValid()->Bool{
        guard let email = insertNameTxtFld.text, insertNameTxtFld.text?.count != 0 else {
            let alert = UIAlertController(title: "Please Enter valid email.", message: "Please enter valid email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
            present(alert, animated: true)
            return false
        }
        if checkEmailIsValid(emailID: email) == false{
            let alert = UIAlertController(title: "Please Enter valid email.", message: "Please enter valid email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
            present(alert, animated: true)
            return false
        }
        return true
    }
}
extension ViewController{
    func checkPasswordLength() -> Bool{
        if passwordFieldTxtFld.text!.count  >= 8{
            return true
        }
        return false
    }
}
extension ViewController{
    func checkEmailIsValid(emailID:String) ->Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}
extension ViewController{
    func comparePasswordAndRepeatPassword()->Bool{
        if repeatPasswordTxtFld.text == passwordFieldTxtFld.text{
            return true
        }
        return false
    }
}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == insertNameTxtFld {
            print("button tap")
            //insertNameTxtFld.resignFirstResponder()
            passwordFieldTxtFld.becomeFirstResponder()
        }
        if textField == passwordFieldTxtFld{
            print("button")
            //passwordFieldTxtFld.resignFirstResponder()
            repeatPasswordTxtFld.becomeFirstResponder()
        } else{
            print("text:\(textField)")
            repeatPasswordTxtFld.resignFirstResponder()
        }
       return true
      }
}

extension ViewController{
    
    private func setInserNameTxtFldProperties(){
        insertNameTxtFld.setDefaultTextFieldProperties()
    }
    
    private func setInsertUsernameProperties(){
        insertUsernameTxtFld.setDefaultTextFieldProperties()
    }
    private func setrepeatPasswordTxtFldProperties(){
        repeatPasswordTxtFld.setDefaultTextFieldProperties()
    }
    private func setPasswordTxtFldProperties(){
        passwordFieldTxtFld.setDefaultTextFieldProperties()
    }
    func setTxtFldProperties(){
        setInsertUsernameProperties()
        setInserNameTxtFldProperties()
        setPasswordTxtFldProperties()
        setrepeatPasswordTxtFldProperties()
    }
    
}


//extension ViewController{
//    func loader() -> UIAlertController{
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.large
//        loadingIndicator.startAnimating()
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
//        return alert
//    }
//    func stopLoader(loader : UIAlertController, completionHandler : @escaping ()->()) {
//            DispatchQueue.main.async {
//                loader.dismiss(animated: true, completion: {
//                    completionHandler()
//                })
//            }
//        }
//
//}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
