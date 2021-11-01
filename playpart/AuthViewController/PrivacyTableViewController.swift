//
//  PrivacyTableViewController.swift
//  playpart
//
//  Created by saba majid on 02/10/2021.
//


import UIKit

class PrivacyTableViewController: UITableViewController {
    
    @IBOutlet weak var staticTableViewCell1: UITableViewCell!
    @IBOutlet weak var section2cell1: UITableViewCell!
    @IBOutlet weak var section2cell2: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor =  .black
        backgroundColor()
    }
    
    func backgroundColor()
    {
        self.staticTableViewCell1.backgroundColor = UIColor.black
        self.section2cell1.backgroundColor = UIColor.black
        self.section2cell2.backgroundColor = UIColor.black
    }
}

