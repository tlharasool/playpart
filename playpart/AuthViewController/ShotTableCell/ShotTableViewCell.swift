//
//  ShotTableViewCell.swift
//  VideoSliderPlayPart
//
//  Created by saba majid on 27/09/2021.
//

import UIKit
import AVFoundation

class ShotTableViewCell: UITableViewCell, ASAutoPlayVideoLayerContainer {
    
  @IBOutlet var shotImageView: UIImageView!
    var playerController: ASVideoPlayerController?
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                print("\n\n")
                print("The video URL is here",videoURL)
                ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
            }
            
            videoLayer.isHidden = videoURL == nil
            print("The video url is",videoLayer.isHidden)
            videoLayer.player?.play()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //        shotImageView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.7)
        //        shotImageView.clipsToBounds = true
    videoLayer.videoGravity = .resizeAspectFill
    shotImageView.layer.addSublayer(videoLayer)
      //  selectionStyle = .none
    }
    func configureCell(imageUrl: String?,
                       description: String,
                       videoUrl: String?) {
        //self.descriptionLabel.text = description
        // self.shotImageView.imageURL = imageUrl
        self.videoURL = videoUrl
    }
    
    override func prepareForReuse() {
     //   shotImageView.imageURL = nil
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoLayer.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
    }
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(shotImageView.frame, from: shotImageView)
        guard let videoFrame = videoFrameInParentSuperView,
              let superViewFrame = superview?.frame else {
            return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
}

