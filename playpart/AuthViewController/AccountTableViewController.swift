//
//  AccountTableViewController.swift
//  playpart
//
//  Created by saba majid on 02/10/2021.
//


import UIKit



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
        self.navigationController?.hideBar()
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
        section2cell4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnLogout(_:))))
        section2cell3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnAccount(_:))))
    }
}


//MARK:- Tap Gesture Recognizer
extension AccountTableViewController{
    
    @objc func addTapOnPrivacy(_ sender : UITapGestureRecognizer){
        
    }
    
    @objc func addTapOnAccount(_ sender : UITapGestureRecognizer){
        let vc = PersonalInfoTableViewController.instantiateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func addTapOnLogout(_ sender : UITapGestureRecognizer){
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
