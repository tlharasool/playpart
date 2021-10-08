//
//  RecordVideoViewController.swift
//  playpart
//
//  Created by talha on 06/10/2021.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Foundation

class RecordVideoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cameraView : UIView!
    @IBOutlet weak var cameraBtnView : UIImageView!
    @IBOutlet weak var galleryBtn : UIButton!

    @objc func actionOnGallery(_ sender : UIButton){
        self.openGallery()
    }
    
    lazy var cameraController : CamerViewController = {
        let controller = CamerViewController.instantiateViewController()
        self.add(asChildViewController: controller, to: cameraView)
        return controller
    }()
    
    var miliSeconds : Int = 0
    var longPressRecognizer : UILongPressGestureRecognizer!
    var picker:UIImagePickerController? = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabItem = UITabBar()
        tabItem.isHidden = true
        picker?.delegate = self
        self.backBtn.addTarget(self, action: #selector(actionOnBackBtn(_:)), for: .touchUpInside)
        
        cameraBtnView.isUserInteractionEnabled = true
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPressRecognizer.numberOfTouchesRequired = 1
        longPressRecognizer.minimumPressDuration = 0.5
        self.cameraBtnView.addGestureRecognizer(longPressRecognizer)
        galleryBtn.addTarget(self, action: #selector(actionOnGallery(_:)), for: .touchUpInside)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cameraController.startCameraSession()
        self.view.bringSubviewToFront(backBtn)
        self.view.bringSubviewToFront(cameraBtnView)
        self.view.bringSubviewToFront(galleryBtn)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.hideBar(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func openCameraController(){
        cameraController.view.frame = self.view.frame
        view.addSubview(cameraController.view)
        
    }
    
    func openGallery(){
        picker!.allowsEditing = false
        
        //picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        //present(picker!, animated: true, completion: nil)
        //picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker!.sourceType = .savedPhotosAlbum
        picker!.mediaTypes = [kUTTypeMovie as String]
        picker?.delegate = self
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
            
            return }
        
        print(mediaURL)
        
        let asset = AVAsset(url: mediaURL)
        
        let duration = asset.duration
        let durationTime = CMTimeGetSeconds(duration)
        //let videoTime = round(durationTime)
        //print(videoTime)
        if round(durationTime) <= 15{
            print("Video is acceptable")
            openDescriptionController(mediaURL)
        }else{
            print("Video is no acceptable")
            self.showAlertWithAction(messageToDisplay: "Can't upload video of duration greater than 15 seconds") {
                
            }
        }

    }
    
    
}


extension RecordVideoViewController{
    @objc func actionOnBackBtn(_ sender : UIButton){
        self.tabBarController?.selectedIndex = 0
    }
}


extension RecordVideoViewController{
    
    func openDescriptionController(_ videoURL : URL){
        let vc = RecordVideoInfoController.instantiateViewController()
        vc.videoURL = videoURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecordVideoViewController :  UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPopoverControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

extension RecordVideoViewController{
    
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        
        switch gesture.state {
        case .possible:
            print("Possible")
        case .began:
            
            self.miliSeconds = 0
            print("Began")
            
            self.cameraController.record { videoURL in
                self.openDescriptionController(videoURL)
            } error: { error in
                print("Error")
            }
            
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.cameraBtnView.transform = CGAffineTransform(scaleX: 2, y: 2)
                           })
            
        case  .changed:
            print("\nChanges\n")
            self.miliSeconds += 1
            
            if miliSeconds == 15{
                print("Acheived")
                gesture.isEnabled = false
                
            }
            
        case .ended:
            print("ended")
            self.cameraController.stopMovieRecording()
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.cameraBtnView.transform = .identity
                           })
            longPressRecognizer.isEnabled = true
            miliSeconds = 0
        case .cancelled:
            self.cameraController.stopMovieRecording()
            print("cancelled")
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.cameraBtnView.transform = .identity
                           })
            longPressRecognizer.isEnabled = true
            miliSeconds = 0
        case .failed:
            print("failed")
        @unknown default:
            print("default")
        }
    }
    
}


