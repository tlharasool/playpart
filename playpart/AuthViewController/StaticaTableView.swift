//
//  StaticaTableViewTableViewController.swift
//  VideoSliderPlayPart
//
//  Created by saba majid on 28/09/2021.
//


import Foundation
import UIKit

class StaticaTableView: UITableViewController {
    //@IBOutlet var tableView: UITableView!
    
    
    @IBOutlet weak var staticTableViewCell1: UITableViewCell!
    @IBOutlet weak var section2cell1: UITableViewCell!
    @IBOutlet weak var section2cell2: UITableViewCell!
    @IBOutlet weak var section2cell3: UITableViewCell!
    @IBOutlet weak var section2cell4: UITableViewCell!
    @IBOutlet weak var section3cell1: UITableViewCell!
    @IBOutlet weak var section3cell2: UITableViewCell!
    
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
        self.section2cell3.backgroundColor = UIColor.black
        self.section2cell4.backgroundColor = UIColor.black
        self.section3cell1.backgroundColor = UIColor.black
        self.section3cell2.backgroundColor = UIColor.black
    }
}

