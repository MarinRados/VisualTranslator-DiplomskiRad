//
//  UIViewController+Extensions.swift
//  VisualTranslator
//
//  Created by Marin Rados on 06/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

extension UIViewController {

    var window: UIWindow? {
        return self.view.window ?? (UIApplication.shared.delegate as! AppDelegate).window
    }
    
    func showAsRoot() {
        guard let window = window else {
            return
        }
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
    
    open class func instance() -> Self {
        if let vc = createFromStoryboard(type: self) {
            return vc
        } else {
            print("WARNING: can't create view controller from storybard:\(self)")
            return self.init()
        }
    }
    
    private class func createFromStoryboard<T: UIViewController>(type: T.Type) -> T? {
        
        let storyboardName = String(describing: type)
        
        let bundle = Bundle(for: T.self)
        
        guard bundle.path(forResource: storyboardName, ofType: "storyboardc") != nil else {
            return nil
        }
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        
        guard let vc = storyboard.instantiateInitialViewController() else {
            print("no vc in storyboard(hint: check initial vc)") ; return nil
        }
        
        return vc as? T
    }
}
