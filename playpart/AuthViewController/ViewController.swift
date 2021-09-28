//
//  ViewController.swift
//  playpart
//
//  Created by Atif Habib on 09/09/2021.
//

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController{
    
    @IBOutlet weak var insertNameTxtFld: UITextField!
    @IBOutlet weak var passwordFieldTxtFld: UITextField!
    @IBOutlet weak var repeatPasswordTxtFld: UITextField!
    @IBOutlet weak var insertView : UIView!
    
   // let leftViewspace = leftView()
    
    let apiHandler = API_Handler.shared
    private let primaryColor = AppColor.primaryColor
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
        
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
    func serverSide(){
        let loader =  self.loader()
        let params = ["email" : insertNameTxtFld.text,"password" : passwordFieldTxtFld.text,"password_confirmation" : repeatPasswordTxtFld.text]
        apiHandler.registerUser(parameters: params, success: {msg in
            
            self.stopLoader(loader: loader) {
            
                DispatchQueue.main.async {
                    print("Enter Sucessfully")
                    self.popUpSreenAfterSignUp()
                    /*let alert = UIAlertController(title: "Sucessfully", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
                    self.present(alert, animated: true)
                    print("error in main que")*/
                    
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
                    print("error in main que")
                    
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
        
        if insertNameTxtFld.text == "" || passwordFieldTxtFld.text == "" || repeatPasswordTxtFld.text == ""{
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
    private func setrepeatPasswordTxtFldProperties(){
        repeatPasswordTxtFld.setDefaultTextFieldProperties()
    }
    private func setPasswordTxtFldProperties(){
        passwordFieldTxtFld.setDefaultTextFieldProperties()
    }
    func setTxtFldProperties(){
        setInserNameTxtFldProperties()
        setPasswordTxtFldProperties()
        setrepeatPasswordTxtFldProperties()
    }
}
extension ViewController{
    func loader() -> UIAlertController{
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    func stopLoader(loader : UIAlertController, completionHandler : @escaping ()->()) {
            DispatchQueue.main.async {
                loader.dismiss(animated: true, completion: {
                    completionHandler()
                })
            }
        }

}
