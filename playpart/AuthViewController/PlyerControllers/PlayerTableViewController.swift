//
//  PlayerTableViewController.swift
//  playpart
//
//  Created by talha on 08/10/2021.
//

import UIKit
import AVFoundation

class PlayerTableViewController: UITableViewController{
    
    // MARK: - Variables
    let cellId = "HomeTableViewCell"
    @objc dynamic var currentIndex = 0
    var oldAndNewIndices = (0,0)
    var data = [VideoData]()
    
    let apiHandler = API_Handler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAudioMode()
        setupView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
 
}

extension PlayerTableViewController{
    
    func setAudioMode() {
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch (let err){
            print("setAudioMode error:" + err.localizedDescription)
        }
    }
    
}

extension PlayerTableViewController{
    
    func pauseVideo(){
        if let cell = tableView.visibleCells.first as? HomeTableViewCell{
            if cell.playerView != nil{
                cell.pause()
            }
        }
    }
    
    func playVideo(){
        if let cell = tableView.visibleCells.first as? HomeTableViewCell{
            if cell.playerView != nil{
                cell.play()
            }
        }
    }
}

extension PlayerTableViewController{
    
    func reactionHandler(reaction: Int, index: Int){
        let obj =  self.data[index]
        if let reactionObj = obj.reaction, reactionObj.reaction != 0{
            print("Updaing...",reactionObj.reaction,"--",reaction)
            obj.reaction?.reaction = reaction
            self.apiHandler.updateNewReaction(reaction: reaction,reactionID: reactionObj.id) {
                print("Updated Successfully")
            } failure: { err in
                print("Error in updating old reaction ")
            }
            
        }else{
            print("Adding new reaction")
            self.apiHandler.setNewReaction(reaction: reaction,videoID: obj.id) {
                print("Reaction Added successfully")
                
                
            } failure: { err in
                print("Error in updating new reaction ")
            }
//            if let cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? HomeTableViewCell{
//                cell.hideReactions()
//            }
            obj.reaction?.reaction = reaction
        }
        
        if let videoCell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? HomeTableViewCell{
            videoCell.hideReactions()
        }
    }
}

extension PlayerTableViewController{
    
    func setupView(){
        // Table View
        
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
        tableView.tableFooterView = UIView()
        tableView.isPagingEnabled = true
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
}
extension PlayerTableViewController : StoryboardInitializable{
    static var storyboardName: UIStoryboard.Storyboard{return .home}
}

extension PlayerTableViewController : UITableViewDataSourcePrefetching{
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}


extension PlayerTableViewController {
    
    func reloadView(data : [VideoData]){
        self.data = data
        self.tableView.reloadData()
    }
}
// MARK: - Table View Extensions
extension PlayerTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.configure(post: data[indexPath.row])
        cell.tag = indexPath.row
        cell.reportbtnOutlet.tag = indexPath.row
       
        cell.reportbtnOutlet.addTarget(self, action: #selector(showActionSheet(_:)), for: .touchUpInside)
        cell.reactionHandler = self.reactionHandler
    //    cell.isVideoFinish   = self.isVideoFinish
        cell.playerView.isReadyToPlay = {
            if indexPath.row == 0{
                cell.play()
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HomeTableViewCell{
            print("Will display cell")
            oldAndNewIndices.1 = indexPath.row
            currentIndex = indexPath.row
            cell.pause()
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Pause the video if the cell is ended displaying
        if let cell = cell as? HomeTableViewCell {
            print("didEndDisplaying")
            cell.pause()
            
//            if currentIndex > 0{
//                print("Playing new video")
//                cell.play()
//            }
        }
    }
}


extension PlayerTableViewController  {
    
    func isVideoFinish(){
        print("The current index when video finished",currentIndex)
        
        if (currentIndex == (data.count - 1)){
            print("We are on the last video")
    
        }else{
            
            oldAndNewIndices.1 = currentIndex
            currentIndex =  currentIndex + 1
            let newIndex = currentIndex
            tableView.scrollToRow(at: IndexPath(row: newIndex, section: 0), at: .bottom, animated: true)
        }
    }
    
}

extension PlayerTableViewController  {

    @objc func showActionSheet(_ sender : UIButton){
    
        let sheet = UIAlertController.init(title: "Are you sure?", message: "You want to perform this action", preferredStyle: .actionSheet)
        
        let blockAction = UIAlertAction(title: "Block", style: .default) { [weak self] action in
            guard let self = self else {return}
            let report = ReportTableViewController.instantiateViewController()
            let vc = UINavigationController(rootViewController: report)
            vc.modalPresentationStyle = .fullScreen
            report.title = "Block User"
            self.present(vc, animated: true, completion: nil)
            
        }
        
        let reportAction = UIAlertAction(title: "Report", style: .default) { [weak self] action in
            guard let self = self else {return}
            let report = ReportTableViewController.instantiateViewController()
            let vc = UINavigationController(rootViewController: report)
            vc.modalPresentationStyle = .fullScreen
            report.title = "Report User"
            self.present(vc, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] action in
            guard let self = self else {return}
            
        }
        sheet.addAction(blockAction)
        sheet.addAction(reportAction)
        sheet.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(sheet,animated: true,completion: nil)
        }
        
    }
    
}

// MARK: - ScrollView Extension

extension PlayerTableViewController  {
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let cell = self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0)) as? HomeTableViewCell
        cell?.replay()
    }
    
    
}
