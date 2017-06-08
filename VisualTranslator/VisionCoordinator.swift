//
//  VisionCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class VisionCoordinator: Coordinator {
    
    private var navigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        let vc = CameraViewController.instance()
        
        navigationController.viewControllers = [vc]
        vc.navigationBarDisplayMode = .always
        return navigationController
    }
}
