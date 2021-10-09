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
    
    var miliSeconds : Int = 0
    var longPressRecognizer : UILongPressGestureRecognizer!
    var picker:UIImagePickerController? = UIImagePickerController()
    var cameraConfig: CameraConfiguration!
    
    var videoRecordingStarted: Bool = false {
        didSet{
            if videoRecordingStarted {
                // self.cameraButton.backgroundColor = UIColor.red
            } else {
                // self.cameraButton.backgroundColor = UIColor.white
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        setUpCameraConfigurations()
        hideTabBar()
        addActionsOnBtn()
        setGestureOnCameraRecordingBtn()
        setGalleryPickerDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.cameraController.startCameraSession()
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
    
}

extension RecordVideoViewController{
    @objc func actionOnBackBtn(_ sender : UIButton){
       // self.tabBarController?.selectedIndex = 0
        self.dismiss(animated: true, completion: nil)
    }
}
extension RecordVideoViewController : StoryboardInitializable{
    
    static var storyboardName: UIStoryboard.Storyboard{return .home}
}

extension RecordVideoViewController{
    
    func openCameraController(){
        //        cameraController.view.frame = self.view.frame
        //        view.addSubview(cameraController.view)
        
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
            
            
            self.recordVideo()
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
            self.stopVideo()
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.cameraBtnView.transform = .identity
                           })
            longPressRecognizer.isEnabled = true
            miliSeconds = 0
        case .cancelled:
            self.stopVideo()
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
//MARK:- Video Recording And Stop Functions
extension RecordVideoViewController{
    
    private func recordVideo(){
        self.cameraConfig.recordVideo { url, err in
            if err != nil{
                let cameraError = err?.localizedDescription ?? ""
                self.showToast(message: cameraError , fontSize: 12)
                return
            }
            guard let url = url else {return}
            self.openDescriptionController(url)
        }
    }
    
    private func stopVideo(){
        self.cameraConfig.stopRecording { err in
            print("\n\n")
            print("The stop video error if any",err?.localizedDescription)
        }
    }
}


extension RecordVideoViewController{
    
    @objc func actionOnGallery(_ sender : UIButton){
        self.openGallery()
    }
    
    private func setGalleryPickerDelegate(){
        picker?.delegate = self
    }
    
    private func addActionsOnBtn(){
        
        backBtn.addTarget(self, action: #selector(actionOnBackBtn(_:)), for: .touchUpInside)
        galleryBtn.addTarget(self, action: #selector(actionOnGallery(_:)), for: .touchUpInside)
        
    }
    
    private func setGestureOnCameraRecordingBtn(){
        
        cameraBtnView.isUserInteractionEnabled = true
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPressRecognizer.numberOfTouchesRequired = 1
        longPressRecognizer.minimumPressDuration = 0.5
        self.cameraBtnView.addGestureRecognizer(longPressRecognizer)
    }
    
    private func hideTabBar(){
        let tabItem = UITabBar()
        tabItem.isHidden = true
    }
    
    private func setUpCameraConfigurations(){
        self.cameraView.alpha = 0
        self.cameraConfig = CameraConfiguration()
        
        cameraConfig.setup { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            do {
                try self.cameraConfig.displayPreview(self.view)
            }catch let err{
                self.showToast(message: err.localizedDescription, fontSize: 12)
            }
            
        }
    }
    
}



//    lazy var cameraController : CamerViewController = {
//        let controller = CamerViewController.instantiateViewController()
//        self.add(asChildViewController: controller, to: cameraView)
//        return controller
//    }()
