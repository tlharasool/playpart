//
//  RecordViewController.swift
//  playpart
//
//  Created by talha on 06/10/2021.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var cameraView : UIView!
    
    lazy var cameraController : CamerViewController = {
        let controller = CamerViewController.instantiateViewController()
        self.add(asChildViewController: controller, to: cameraView)
        return controller
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        openCameraController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hideBar(true)
    }
    
    func openCameraController(){
        cameraController.view.frame = self.view.frame
        view.addSubview(cameraController.view)
       
        
    //    present(cameraController, animated: false, completion: nil)
    }

}


extension RecordViewController : StoryboardInitializable{
    static var storyboardName: UIStoryboard.Storyboard{ return .record}
}
