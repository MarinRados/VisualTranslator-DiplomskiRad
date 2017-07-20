//
//  BaseNavigationController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    func customizeNavigationBar(_ navigationItem: UINavigationItem) {
        removeShadowFromNavbar()
        navigationBar.barTintColor = .darkBlue
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    private func removeShadowFromNavbar() {
        navigationBar.shadowImage = UIImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func goBack() {
        self.popViewController(animated: true)
    }
}
