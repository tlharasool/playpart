//
//  ReportSelectionViewDelegateDataSource.swift
//  playpart
//
//  Created by talha on 29/10/2021.
//

import UIKit


class ReportSelectionViewDelegateDataSource : NSObject{
    
    private let nibName = ReportTableViewCell.reuseIdentifier
    var tableView : UITableView!
    var selctedIndexPath : [IndexPath] = []
    var estimatedRides : [String] = [ "Hate Speech", "Violence or dangerous content", "Intellectual property violation", "irrelevant content"]
    
    var selectedReason : String = ""
   
    init(tableView : UITableView){
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelection = false
        self.tableView.separatorStyle = .none
        //self.tableView.singleSelection = true
       self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

extension ReportSelectionViewDelegateDataSource : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row, and instead, show the state with a checkmark.
        if let lastIndexPath = selctedIndexPath.first{
            tableView.deselectRow(at: lastIndexPath, animated: false)
            guard let previouscell = tableView.cellForRow(at: lastIndexPath) else { return }
            previouscell.isSelected = false
            selctedIndexPath.removeAll()
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            cell.isSelected = true
            selctedIndexPath.append(indexPath)
            print("Selection Successfully done",selctedIndexPath.count)
            //tableView.reloadData()
        }else{
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            cell.isSelected = true
            selctedIndexPath.append(indexPath)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

extension ReportSelectionViewDelegateDataSource{
    
    func selectFirstRowDefault(row : Int, section : Int){
        let indexPath = IndexPath(row: row, section: section)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
}

extension ReportSelectionViewDelegateDataSource : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        estimatedRides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath) as! ReportTableViewCell
        cell.reportLbl.text = estimatedRides[indexPath.row]
        cell.selectedIssue = selectedIssue
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func selectedIssue (reason : String) {
        self.selectedReason = reason
    }
}
