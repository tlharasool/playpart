//
//  PersonalInfoTableViewController.swift
//  playpart
//
//  Created by talha on 06/10/2021.
//

import UIKit

class PersonalInfoTableViewController  : UITableViewController {
    
    @IBOutlet weak var backBtn: UIButton!
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

extension PersonalInfoTableViewController{
    
    private func integrateActionOnSection(){
        backBtn.addTarget(self, action: #selector(actionOnBack(_:)), for: .touchUpInside)
        section3cell1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnPassword(_:))))
        
        section2cell3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTapOnName(_:))))
    
    }
}

//MARK:- Action On Buttons
extension PersonalInfoTableViewController{
    
    @objc func actionOnBack(_ sender : UIButton){
        self.navigationController?.popController()
    }
}

extension PersonalInfoTableViewController{
    
    @objc func addTapOnPassword(_ sender : UIButton){
        let vc = SetPasswordViewController.instantiateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addTapOnName(_ sender : UIButton){
        let vc = SetNameViewController.instantiateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension PersonalInfoTableViewController : StoryboardInitializable{
    static var storyboardName: UIStoryboard.Storyboard{ return .main}
}


extension UIViewController{
    @objc func setBackAction(_ sender : UIButton){
        self.navigationController?.popController()
    }
}
