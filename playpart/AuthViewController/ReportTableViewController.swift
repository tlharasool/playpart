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
    let apiHandler = API_Handler.shared
    var videoID : Int!
    var indexPath : IndexPath!
    
    var getVideoIndexPath : ((IndexPath)->Void)?
    
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
            let reason = reportDatasource_Delegate.selectedReason
            let params : [String : Any] =  ["video_id" : videoID, "reason" : reason ]
            let loader =  self.loader()
            
            apiHandler.video_reports(parameters: params) {
                
                self.stopLoader(loader: loader) {
                    self.dismiss(animated: true, completion: { [self] in
                        if let comp = self.getVideoIndexPath{
                            comp(indexPath)
                        }
                    })
                }
            } failure: { err in
                self.stopLoader(loader: loader) {
                    self.showToast(message: err.capitalized, fontSize: 10)
                }
              
            }
            
            
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


