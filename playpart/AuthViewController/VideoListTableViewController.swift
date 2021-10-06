//
//  ViewController.swift
//  VideoSliderPlayPart
//
//  Created by saba majid on 27/09/2021.
//


import UIKit
import AVFoundation

class VideoListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var player: AVPlayer?
    
    let shotTableViewCellIdentifier = "ShotTableViewCell"
    let loadingCellTableViewCellCellIdentifier = "LoadingCellTableViewCell"
    var refreshControl: UIRefreshControl!
    let videos = [
        "https://v.pinimg.com/videos/720p/dd/24/bb/dd24bb9cd68e9e25d1def88cad0a9ea7.mp4",
        "https://v.pinimg.com/videos/720p/d5/15/78/d51578c69d36c93c6e20144e9f887c73.mp4",
        "https://v.pinimg.com/videos/720p/c2/6d/2b/c26d2bacb4a9f6402d2aa0721193e06e.mp4",
        "https://v.pinimg.com/videos/720p/62/81/60/628160e025f9d61b826ecc921b9132cd.mp4",
        "https://v.pinimg.com/videos/720p/5f/aa/3d/5faa3d057eb31dd05876f622ea2e7502.mp4",
        "https://v.pinimg.com/videos/720p/65/b0/54/65b05496c385c89f79635738adc3b15d.mp4",
        "https://v.pinimg.com/videos/720p/86/a1/c6/86a1c63fc58b2e1ef18878b7428912dc.mp4"]
    
    let videoIndexes = [1:0, 4:1, 5:2, 7:3, 9:4, 10:5, 12:6, 13:7, 14:8, 18:9]
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isPagingEnabled = true
        tableView.rowHeight = UITableView.automaticDimension
        var cellNib = UINib(nibName:shotTableViewCellIdentifier, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: shotTableViewCellIdentifier)
        cellNib = UINib(nibName:loadingCellTableViewCellCellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: loadingCellTableViewCellCellIdentifier)
        tableView.separatorStyle = .none
        //   NotificationCenter.default.addObserver(self,selector: #selector(self.appEnteredFromBackground),name: NSNotification.Name.UIApplicationwillEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let center = CGPoint(x: tableView.center.x + tableView.contentOffset.x,y: tableView.center.y + tableView.contentOffset.y)
        
        guard let centerIndex = self.tableView.indexPathForRow(at: center) else {return}
        print("center point - \(center)")
        print("centerIndex - \(centerIndex.row)")
        let autoPlayCell = tableView.cellForRow(at: centerIndex) as? ShotTableViewCell
        autoPlayCell?.videoLayer.player?.pause()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayeVideos()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shotTableViewCellIdentifier, for: indexPath) as! ShotTableViewCell
        if let videoIndex = videoIndexes[indexPath.row] {
            //cell.configureCell(imageUrl: videoImages[videoIndex], description: "Video", videoUrl: videos[indexPath.row])
            cell.configureCell(imageUrl: videos[videoIndex], description: "Video", videoUrl: videos[indexPath.row])
        }
        else{
            // cell.configureCell(imageUrl: videos[indexPath.row], description: "Image", videoUrl: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayeVideos()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayeVideos()
        }
    }
    func pausePlayeVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
    }
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView, appEnteredFromBackground: true)
    }
}

