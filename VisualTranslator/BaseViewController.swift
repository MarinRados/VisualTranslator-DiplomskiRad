//
//  BaseViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    enum NavigationBarDisplayMode {
        case always
        case never
        case automatic
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = self.navigationController as? BaseNavigationController {
            navigationController.customizeNavigationBar(self.navigationItem)
        }
    }
    
    var navigationBarDisplayMode: NavigationBarDisplayMode = .automatic {
        didSet {
            
            guard let navigationController = navigationController else {
                return
            }
            
            switch navigationBarDisplayMode {
            case .always:
                navigationController.isNavigationBarHidden = false
            case .automatic:
                let isFirstViewController = navigationController.viewControllers.count == 1
                navigationController.isNavigationBarHidden = !isFirstViewController
            case .never:
                navigationController.isNavigationBarHidden = true
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
