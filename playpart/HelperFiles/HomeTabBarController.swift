//
//  HomeTabBarController.swift
//  playpart
//
//  Created by talha on 06/10/2021.
//

import UIKit
import Alamofire
class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        AF.request("https://mysneakersapp.herokuapp.com/sneakers/api/sneakers_list").responseJSON { response in
          //  print("JSON is here",response.result,response.error)
            switch response.result{
            
            case .success(let data):
               
               // print(response.result)
                if let json = data as? NSArray{
                    print("The count are here",json.count)
                }
                
            case .failure(let err):
                print(err)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hideBar(true)
    }

}

extension HomeTabBarController : UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if let tabTag = tabBarController.tabBar.selectedItem?.tag, tabTag == 1{
            let vc = RecordVideoViewController.instantiateViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overCurrentContext
            self.present(nav, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}


extension HomeTabBarController : StoryboardInitializable{
    static var storyboardName: UIStoryboard.Storyboard{ return .home}
}
