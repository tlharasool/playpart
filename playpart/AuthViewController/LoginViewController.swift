//
//  LoginViewController.swift
//  playpart
//
//  Created by Atif Habib on 17/09/2021.
//

//UISelectionViewController
import UIKit
import SwiftKeychainWrapper
class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailField    : UITextField!
    @IBOutlet weak var passwordFiled : UITextField!
    @IBOutlet weak var regsiterBtn   : UIButton!
    
    let apiHandler = API_Handler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordFiled.delegate = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setTxtFldProperties()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func loginButton(_ sender: Any) {
        IsFieldsAreEmpty()
       // self.performSegue(withIdentifier: "mainScreen", sender: self)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        //  performSegue(withIdentifier: "scrollView", sender: self)
        
    }
    
    @IBAction func goToSignUppage(_ sender: UIButton) {
        print("called")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func popScreenAfterLogginAndSignUp()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "UISelectionViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    //for email Validation
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    //for passWord validation
    func isValidpassword(passwordString: String) -> Bool {
        if passwordFiled.text!.count  >= 8{
            return true
        }
        return false
        
        /*var returnValue = true
        
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        do {
            let regex = try NSRegularExpression(pattern: passRegEx)
            let nsString = passwordString as NSString
            let results = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue*/
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    //checking is there any field is empty or not
    func IsFieldsAreEmpty()
    {
        if emailField.text == "" || passwordFiled.text == ""
        {
            let alert = UIAlertController(title: "Login", message: "Fill both fileds", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",style: .cancel,handler: {action in}))
            present(alert, animated: true)
        }
        else
        {
            let providedEmailAddress = emailField.text
            let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
            if isEmailAddressValid
            {
                print("Email address is valid")
            } else {
                print("Email address is not valid")
                displayAlertMessage(messageToDisplay: "Email address is not valid")
                return
            }
            // password
            let providedPassword =  passwordFiled.text
            let validPassword = isValidpassword(passwordString: providedPassword!)
            if validPassword
            {
               let loader =  self.loader()
                backEndConfigration(loader: loader)
                print("Password is valid")
            }
            else{
                print("Password is not Valid")
                displayAlertMessage(messageToDisplay: "Password is not valid")
            }
            
        }
    }
    //check either pass and email matches
    func backEndConfigration(loader  : UIAlertController)
    {
            
        let dataDictonary = ["email": emailField.text, "password": passwordFiled.text]
        apiHandler.LogInUser(parameters: dataDictonary, failure:{msg in
      
            DispatchQueue.main.async {
                stopLoader(loader: loader, completionHandler:{
                    
                    let alert = UIAlertController(title: "error", message: msg , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",style: .cancel,handler: {action in}))
                    self.present(alert, animated: true)
                    print("error")
                    
                })
               
            }
        }, success:{msg in
            DispatchQueue.main.async {
                stopLoader(loader: loader, completionHandler: { [self] in
                //    popScreenAfterLogginAndSignUp()
                    
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(identifier: "UITabBarController")
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                    /*let alert = UIAlertController(title: "SuccessFull", message: msg , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",style: .cancel,handler: {action in}))
                    self.present(alert, animated: true)
                    print("sucessfull alert apperas")*/
                })
          
            }
        })
    }
}
extension LoginViewController{
    
}
extension LoginViewController{
    
    private func setEmailTxtFldProperties(){
        emailField.setDefaultTextFieldProperties()
        
    }
    
    private func setPasswordTxtFldProperties(){
        passwordFiled.setDefaultTextFieldProperties()
    }
    func setTxtFldProperties(){
        setEmailTxtFldProperties()
        setPasswordTxtFldProperties()
    }
}
extension LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordFiled.becomeFirstResponder()
        } else
        {
            passwordFiled.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController{
    
    func loader() -> UIAlertController{
        let alert = UIAlertController(title: nil, message: "please wait", preferredStyle: .alert)
        let loadingindicator = UIActivityIndicatorView(frame: CGRect(x:10,y:5, width: 50,height: 50))
        loadingindicator.hidesWhenStopped = true
        loadingindicator.style = UIActivityIndicatorView.Style.large
        loadingindicator.startAnimating()
        alert.view.addSubview(loadingindicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
}


func stopLoader(loader : UIAlertController, completionHandler : @escaping ()->()) {
    DispatchQueue.main.async {
      
        loader.dismiss(animated: true, completion: {
            completionHandler()
        })
    }
    
    
}
