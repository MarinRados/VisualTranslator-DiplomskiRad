//
//  QuizCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit


final class QuizCoordinator: Coordinator {
    
    private var navigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        let vc = MenuViewController.instance()
        
        navigationController.viewControllers = [vc]
        vc.navigationBarDisplayMode = .always
        return navigationController
    }
}
