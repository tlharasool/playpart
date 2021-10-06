//
//  NavigationExt.swift
//  Boxeyi
//
//  Created by talha on 01/09/2019.
//  Copyright © 2019 Boxeyi. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func popController(){
        self.popViewController(animated: true)
    }
    
    
    func popControllerWithCompletion(completion : @escaping ()->()){
        self.popViewController(animated: true)
        completion()
    }
    
    

    func popBack(_ nb: Int) {
        let viewControllers: [UIViewController] = self.viewControllers
        guard viewControllers.count < nb else {
            self.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
            return
        }
    }
    
    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        var viewControllers: [UIViewController] = self.viewControllers
        viewControllers = viewControllers.reversed()
        for currentViewController in viewControllers {
            if currentViewController .isKind(of: toControllerType) {
                self.popToViewController(currentViewController, animated: true)
                break
            }
        }
    }
    
    
    
    func hideBar(_ animated : Bool){
           self.setNavigationBarHidden(true, animated: animated)
      }
    func hideBar(){
         self.setNavigationBarHidden(true, animated: true)
    }
    func showBar(){
           self.setNavigationBarHidden(false, animated: true)
      }
    
    func removeNavColor(){
        self.navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        //self.view.backgroundColor = .clear
    }
    
    
    func setNavigationBarColor(color : UIColor){
        self.navigationBar.barTintColor = color
    }
    
    func setNavigationTitleColor(color : UIColor){
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color]
    }
    
    
    
}

extension UINavigationBar {
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
