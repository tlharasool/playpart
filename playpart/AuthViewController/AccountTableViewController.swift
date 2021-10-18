//
//  AccountTableViewController.swift
//  playpart
//
//  Created by saba majid on 02/10/2021.
//


import UIKit
import SwiftKeychainWrapper


class AccountTableViewController : UITableViewController {
    
    @IBOutlet weak var staticTableViewCell1: UITableViewCell!
    @IBOutlet weak var section2cell1: UITableViewCell!
    @IBOutlet weak var section2cell2: UITableViewCell!
    @IBOutlet weak var section2cell3: UITableViewCell!
    @IBOutlet weak var section2cell4: UITableViewCell!
    @IBOutlet weak var section3cell1: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor =  .black
        backgroundColor()
        
        integrateActionOnSection()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hideBar(false)
    }
    
    func backgroundColor()
    {
        self.staticTableViewCell1.backgroundColor = UIColor.black
        self.section2cell1.backgroundColor = UIColor.black
        self.section2cell2.backgroundColor = UIColor.black
        self.section2cell3.backgroundColor = UIColor.black
        self.section2cell4.backgroundColor = UIColor.black
        self.section3cell1.backgroundColor = UIColor.black
        
    }
    


}


//MARK:- Actions
extension AccountTableViewController{
    
  private func integrateActionOnSection(){
    section2cell2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnPrivacy(_:))))
        section2cell4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnLogout(_:))))
        section2cell3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnAccount(_:))))
    }
}


//MARK:- Tap Gesture Recognizer
extension AccountTableViewController{
    
    @objc func addTapOnPrivacy(_ sender : UITapGestureRecognizer){
        
        let vc = PDFController()
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func addTapOnAccount(_ sender : UITapGestureRecognizer){
        let vc = PersonalInfoTableViewController.instantiateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func addTapOnLogout(_ sender : UITapGestureRecognizer){
        
        CustomUserDefaults.shared.set(false, key: .isLogin)
        //KeychainWrapper.standard.set(accessToken, forKey: AppKey.accessToken.value)
        KeychainWrapper.standard.remove(forKey: KeychainWrapper.Key(rawValue: AppKey.accessToken.value) ?? "")
        let vc = LoginViewController.instantiateViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootVC(nav)
    }
}

//MARK:- Action On Button
extension AccountTableViewController{
    
    @objc func actionHelpBtn(_ sender : UIButton){
        
    }
    
    @objc func actionCopyrightBtn(_ sender : UIButton){
        
    }
}

extension AccountTableViewController : StoryboardInitializable{
    static var storyboardName: UIStoryboard.Storyboard{ return .main}
}



import UIKit
import PDFKit

class PDFController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        self.view.addSubview(pdfView)

        // Fit content in PDFView.
        pdfView.autoScales = true

        // Load Sample.pdf file.
        let fileURL = Bundle.main.url(forResource: "privacyPolicy", withExtension: "pdf")
        pdfView.document = PDFDocument(url: fileURL!)
    }

}
