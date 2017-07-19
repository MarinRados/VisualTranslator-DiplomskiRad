//
//  InfoCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 19/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class InfoCoordinator: NavCoordinator, Coordinator {
    
    private var navigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        let vc = InfoViewController.instance()
        
        navigationController.viewControllers = [vc]
        vc.navigationBarDisplayMode = .always
        return navigationController
    }
}
