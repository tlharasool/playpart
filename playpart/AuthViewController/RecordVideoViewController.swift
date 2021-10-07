//
//  RecordVideoViewController.swift
//  playpart
//
//  Created by talha on 06/10/2021.
//

import UIKit
import LongPressRecordButton

class RecordVideoViewController: UIViewController, UIGestureRecognizerDelegate {
    

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cameraView : UIView!
//    @IBOutlet weak var camerRecordBtnView: UIImageView!


    @IBOutlet weak var camerRecordBtn: LongPressRecordButton!
    
    lazy var cameraController : CamerViewController = {
        let controller = CamerViewController.instantiateViewController()
        self.add(asChildViewController: controller, to: cameraView)
        return controller
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabItem = UITabBar()
        tabItem.isHidden = true
        
      
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
     //   longPress.minimumPressDuration = 5
      //  longPress.numberOfTouches = 1
        longPress.numberOfTouchesRequired = 1
        //longPress.allowableMovement = 50
     //   longPress.minimumPressDuration = 1
        
           self.camerRecordBtn.addGestureRecognizer(longPress)

      
        openCameraController()
        self.backBtn.addTarget(self, action: #selector(actionOnBackBtn(_:)), for: .touchUpInside)
        
    }
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
     
        print("The satte is here")
        print(gesture.state)
        if gesture.state == UIGestureRecognizer.State.began {
            print("Long Press")
            UIView.animate(withDuration: 0.2) {
                self.camerRecordBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
          
        }else if gesture.state == UIGestureRecognizer.State.ended{
            print("ended")
           
            
            UIView.animate(withDuration: 0.2) {
                self.camerRecordBtn.transform = .identity
            }
        }else{
            print("Main ended")
            UIView.animate(withDuration: 0.2) {
                self.camerRecordBtn.transform = .identity
            }
        }
        
        guard UserDefaults.standard.bool(forKey: "SwitchState") else { return }

        let generator = UIImpactFeedbackGenerator(style: .heavy)
                   generator.impactOccurred()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
 
        
        cameraController.startCameraSession()
        self.view.bringSubviewToFront(self.backBtn)
        self.view.bringSubviewToFront(self.camerRecordBtn)
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

}

extension RecordVideoViewController{
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        print("The sender state",sender.state)
        switch sender.state {
        case .began:
            print("Began")
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.camerRecordBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
            },
                           completion: nil)
        case .ended:
            print("ended")
            UIView.animate(withDuration: 0.1) {
                self.camerRecordBtn.transform = CGAffineTransform.identity
            }
        default: break
        }
        
        guard UserDefaults.standard.bool(forKey: "SwitchState") else { return }

         let generator = UIImpactFeedbackGenerator(style: .light)
         generator.impactOccurred()
       
    }
}

extension RecordVideoViewController{
    @objc func actionOnBackBtn(_ sender : UIButton){
        self.tabBarController?.selectedIndex = 0
    }
}
