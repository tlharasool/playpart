//
//  UIApplication + Extenison.swift
//  toyshop
//
//  Created by talha on 07/04/2021.
//


import UIKit

extension UIApplication {
    
    func setRootVC(_ vc : UIViewController){
        
        self.windows.first?.rootViewController = vc
        self.windows.first?.makeKeyAndVisible()
        
    }
}


extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release).\(build)"
    }
}

