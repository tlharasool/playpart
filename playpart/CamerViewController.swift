//
//  CamerViewController.swift
//  playpart
//
//  Created by talha on 06/10/2021.
//

import UIKit
import AVFoundation
import AVKit

class CamerViewController : UIViewController, StoryboardInitializable, AVCaptureFileOutputRecordingDelegate {
    
    var recordCallback: (URL) -> Void = { (_) in }
    var errorCallback: (Error) -> Void = { (_) in }
    
    var isRecording = false
    
    // MARK: Local Variables
    var recordedURL : URL!
    var captureSession: AVCaptureSession?  = AVCaptureSession()
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var movieOutput = AVCaptureMovieFileOutput()
    var videoCaptureDevice : AVCaptureDevice?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        captureSession!.sessionPreset = AVCaptureSession.Preset.photo
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
       
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
           stillImageOutput = AVCapturePhotoOutput()

            if captureSession!.canAddOutput(stillImageOutput!) {
                captureSession?.addOutput(movieOutput)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                self.view.layer.addSublayer(previewLayer!)
                
              
            }
        }
        
    
    }
    
    func startCameraSession(){
        captureSession!.startRunning()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = self.view.bounds
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
 
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(animated)
        captureSession!.stopRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}



extension CamerViewController{
    
    public func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        
        print("Is reording")
        self.isRecording = true
    }
    
    
    
    func stop() {
        print("Stop calling")
        
        self.movieOutput.stopRecording()
        
        
    }
    
    
    
    @objc public func record(url: URL? = nil, _ callback: @escaping (URL) -> Void, error: @escaping (Error) -> Void) {
        if self.isRecording { return }
        
        self.recordCallback = callback
        self.errorCallback = error
        
        let fileUrl: URL = url ?? {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileUrl = paths[0].appendingPathComponent("output.mov")
            try? FileManager.default.removeItem(at: fileUrl)
            return fileUrl
        }()
        
        if let connection = self.movieOutput.connection(with: .video) {
         //   connection.videoOrientation = UIDevice.current.orientation.videoOrientation
        }
        
        self.movieOutput.startRecording(to: fileUrl, recordingDelegate: self)
    }
    
    
    func stopMovieRecording(){
        self.movieOutput.stopRecording()
    }
    
}

extension CamerViewController {
    static var storyboardName: UIStoryboard.Storyboard{return .record}
}

extension CamerViewController{
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        self.isRecording = false
        
        defer {
            self.recordCallback = { (_) in }
            self.errorCallback = { (_) in }
        }
        
        if let error = error {
            self.errorCallback(error)
            return
        }
        
        self.recordCallback(outputFileURL)
    }
}




