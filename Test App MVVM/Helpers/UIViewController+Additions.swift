//
//  UIViewController+Additions.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import UIKit

extension UIViewController {
    
    @objc class var storyboard: UIStoryboard? {
        get {
            return UIStoryboard.init(name: String.init(describing: self), bundle: Bundle.main)
        }
    }
    
    class func instantiate() -> Self {
        return self.instantiate(as: self)
    }
    
    private class func instantiate<T>(as type: T.Type) -> T {
        return  self.storyboard!.instantiateViewController(withIdentifier: String.init(describing: self)) as! T
    }
}
