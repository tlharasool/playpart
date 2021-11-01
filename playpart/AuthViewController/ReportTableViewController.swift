//
//  ReportTableViewController.swift
//  playpart
//
//  Created by talha on 29/10/2021.
//

import UIKit

class ReportTableViewController : UIViewController {
    
    //MARK:- Outelts
    @IBOutlet weak var reportTableView : UITableView!{
        didSet{
            reportTableView.delegate = reportDatasource_Delegate
            reportTableView.dataSource = reportDatasource_Delegate
        }
    }
    
    //MARK:- Variables
    private var reportDatasource_Delegate : ReportSelectionViewDelegateDataSource!
}

extension ReportTableViewController : StoryboardInitializable{
    
    static var storyboardName: UIStoryboard.Storyboard{return .home}
}

extension ReportTableViewController{
    
    @IBAction func reportBtnAction(_ sender: Any) {
        
        print("Tapped on button",reportDatasource_Delegate.selectedReason.isEmpty)
        if reportDatasource_Delegate.selectedReason.isEmpty{
            self.showToast(message: "Please seleect one option", fontSize: 10)
        }else{
            print("Tapped on button",reportDatasource_Delegate.selectedReason)
        }
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Life-Cycles
extension ReportTableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportDatasource_Delegate = ReportSelectionViewDelegateDataSource(tableView: self.reportTableView)
        view.backgroundColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.title = self.title
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
}


extension ReportTableViewController{
    
    @IBAction func actionOnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


