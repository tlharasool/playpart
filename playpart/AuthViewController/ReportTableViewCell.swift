//
//  ReportTableViewCell.swift
//  playpart
//
//  Created by talha on 29/10/2021.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ReportTableViewCell"
    @IBOutlet weak var reportLbl: UILabel!
    var selectedIssue : ((String) -> ())?
    
    override var isSelected: Bool{
        
        didSet{
            if isSelected{
                reportLbl.textColor = UIColor.white
                self.backgroundColor = AppColor.primaryColor

                callReportCompletion(reportLbl.text ?? "")
            }else{
                reportLbl.textColor = UIColor.black
                self.backgroundColor = UIColor.white
                //callReportCompletion(reportLbl.text ?? "")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reportLbl.backgroundColor = UIColor.clear
    }
    
    
    func callReportCompletion(_ reportReason : String){
        if let comp = self.selectedIssue{
            comp(reportReason)
        }
    }
}
