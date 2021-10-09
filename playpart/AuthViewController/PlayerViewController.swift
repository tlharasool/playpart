//
//  ViewController.swift
//  VideoSliderPlayPart
//
//  Created by saba majid on 27/09/2021.
//

import UIKit
import AVFoundation
import MMPlayerView

class PlayerViewController  : UIViewController {
    
    @IBOutlet weak var playerView : UIView!

    var videosData : [VideoData] = []
    lazy var playerController : PlayerTableViewController = {
        let controller = PlayerTableViewController.instantiateViewController()
        self.add(asChildViewController: controller, to: playerView)
        return controller
    }()

    //Variables
    let apiHandler = API_Handler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideosFromServer()
        setupVideoNotifier()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.popController()
        playerController.playVideo()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerController.pauseVideo()
    }
}


extension PlayerViewController{
    
    func getVideosFromServer(){
        let loader  = self.loader(msg: "Loading Videos")
        apiHandler.getAllVideos { data in
            loader.dismiss(animated: true) {
                self.videosData = data
                print("The First Reaction is here",self.videosData.first?.reaction.reaction)
                self.playerController.reloadView(data: data)
            }
           
        } failure: { err in
            loader.dismiss(animated: true) {
                self.showToast(message: err, fontSize: 12)
            }
        }
    }
    
    @objc func videoUpdateNotifier(notification: Notification) {
        
        self.videosData.removeAll()
        apiHandler.getAllVideos { data in
            self.videosData = data
            self.playerController.reloadView(data: data)
        } failure: { errr in
            print("Err",errr)
        }
    }
    
}

extension PlayerViewController{
    
    func setupVideoNotifier(){
        NotificationCenter.default.addObserver(self, selector: #selector(videoUpdateNotifier), name: .updateVideoPlayer, object: nil)
    }
    
}


extension Notification.Name {
    static let updateVideoPlayer = Notification.Name("com.playpart.video")
}
