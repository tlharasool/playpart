//
//  SetPasswordViewController.swift
//  playpart
//
//  Created by saba majid on 02/10/2021.
//


import UIKit

class SetPasswordViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    private let primaryColor = AppColor.primaryColor
    
    let apiHandler = API_Handler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
        backBtn.addTarget(self, action: #selector(actionOnBack(_:)), for: .touchUpInside)
    }
    @IBAction func LoginBtn(_ sender: UIButton) {
        view.endEditing(true)
        checkEntities()
    }
}
extension SetPasswordViewController{
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handelTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handelTap(){
        view.endEditing(true)
    }
}
extension SetPasswordViewController{
    private func configureTextFields(){
        PasswordField.delegate = self
        ConfirmPasswordField.delegate = self
    }
    
    @objc func actionOnBack(_ sender : UIButton){
        self.navigationController?.popController()
    }
}
extension SetPasswordViewController{
    func signUp(){
    }
    func checkEntities(){
        if PasswordField.text == "" || ConfirmPasswordField.text == ""{
            let alert = UIAlertController(title: "Please fill all the manadatory fields.", message: "Please enter all the values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
            present(alert, animated: true)
        }
        else{
            //MARK:- Regex + Password + Repead password
            if checkPasswordLength() == false{
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
                let loader = loader(msg: "Updating password")
                print("OK")
                
                apiHandler.updatePassword(password: PasswordField.text!) {
                    loader.dismiss(animated: true) {
                        
                        self.showToast(message: "Password updated", fontSize: 12)
                    }
                  
                } failure: { err in
                    
                    loader.dismiss(animated: true) {
                        self.showToast(message: err, fontSize: 12)
                    }
                }

                
            }
        }
    }
}
extension SetPasswordViewController{
    func checkPasswordLength() -> Bool{
        if PasswordField.text!.count  >= 8{
            return true
        }
        return false
    }
}
extension SetPasswordViewController{
    func checkEmailIsValid(emailID:String) ->Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}
extension SetPasswordViewController{
    func comparePasswordAndRepeatPassword()->Bool{
        if PasswordField.text == ConfirmPasswordField.text{
            return true
        }
        return false
    }
}

extension SetPasswordViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == PasswordField{
            print("button")
            ConfirmPasswordField.becomeFirstResponder()
        } else{
            print("text:\(textField)")
            ConfirmPasswordField.resignFirstResponder()
        }
        return true
    }
}
extension SetPasswordViewController{
    
    private func setrepeatPasswordTxtFldProperties(){
        PasswordField.setDefaultTextFieldProperties()
    }
    private func setPasswordTxtFldProperties(){
        ConfirmPasswordField.setDefaultTextFieldProperties()
    }
    func setTxtFldProperties(){
        setPasswordTxtFldProperties()
        setrepeatPasswordTxtFldProperties()
    }
}

extension SetPasswordViewController : StoryboardInitializable{
    static var storyboardName: UIStoryboard.Storyboard{
        return .main
    }
}
