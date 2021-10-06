//
//  StoryboardIntialize.swift
//  toyshop
//
//  Created by talha on 27/04/2021.
//


import Foundation
import UIKit


protocol StoryboardInitializable {
    
    static var storyboardIdentifier : String{ get }
    static var storyboardName : UIStoryboard.Storyboard {get}
    static func instantiateViewController() -> Self
    
}


extension UIStoryboard {
    
    enum Storyboard : String {
        
        case main
        case home
       case record
        var filename : String {
            print("{- - The Current file name - -}\(rawValue.capitalized)")
            return rawValue.capitalized
        }
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
}

extension StoryboardInitializable where Self:UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static var storyboardName : UIStoryboard.Storyboard {
        return UIStoryboard.Storyboard.main
    }
    
    static func instantiateViewController() -> Self{
        
        print("\n\n The Storyboard name and vc name", storyboardName, Self.self)
        let storyboard = UIStoryboard.storyboard(storyboard: storyboardName)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
    
}


protocol NibLoadableView : class { static var nibName : String {get} }

extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String(describing: self).components(separatedBy: ".").last!
    }
   static func loadNib() -> Self {
        let bundle = Bundle(for:Self.self)
        let nib = UINib(nibName: Self.nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
