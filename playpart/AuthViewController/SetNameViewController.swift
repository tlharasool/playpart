//
//  SetNameViewController.swift
//  playpart
//
//  Created by saba majid on 02/10/2021.
//


import UIKit

class SetNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var SetNameField: UITextField!
    private let primaryColor = AppColor.primaryColor
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
    }
    @IBAction func LoginBtn(_ sender: UIButton) {
        view.endEditing(true)
        checkEntities()
    }
}
extension SetNameViewController{
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handelTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handelTap(){
        view.endEditing(true)
    }
}
extension SetNameViewController{
    private func configureTextFields(){
        SetNameField.delegate = self
    }
}
extension SetNameViewController{
    func signUp(){
    }
    func checkEntities(){
        if  SetNameField.text == ""{
            let alert = UIAlertController(title: "Please fill the field.", message: "Please enter value", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
            present(alert, animated: true)
        }
        else{
            //MARK:- Regex
            if NameIsValid() == false{
                let alert = UIAlertController(title: "Please fill all the manadatory fields.", message: "Please enter all the values.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
                present(alert, animated: true)
            }
            
            else{
                
                print("OK")
            }
        }
    }
}
extension SetNameViewController{
    func NameIsValid()->Bool{
        guard let email = SetNameField.text, SetNameField.text?.count != 0 else {
            return false
        }
        if CHeckNameIsValid(emailID: email) == false{
            let alert = UIAlertController(title: "Please Enter valid Name.", message: "Please enter valid Name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in}))
            present(alert, animated: true)
            return false
        }
        return true
    }
}
extension SetNameViewController{
    func CHeckNameIsValid(emailID:String) ->Bool {
        let NameRegEx = "^([a-zA-Z]{2,}\\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\\s?([a-zA-Z]{1,})?)"
        let NameTest = NSPredicate(format: "SELF MATCHES %@", NameRegEx)
        return NameTest.evaluate(with: emailID)
    }
}
extension SetNameViewController{
    
    private func setInserNameTxtFldProperties(){
        SetNameField.setDefaultTextFieldProperties()
    }
    func setTxtFldProperties(){
        setInserNameTxtFldProperties()
    }
}
