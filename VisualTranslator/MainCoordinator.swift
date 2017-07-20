//
//  MainCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 06/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit
import Foundation

final class MainCoordinator: Coordinator {
    
    fileprivate var childCoordinators: [Coordinator] = [
        VisionCoordinator(),
        QuizCoordinator(),
        InfoCoordinator()
    ]
    
    @discardableResult
    func start()-> UIViewController {
        return startVision()
    }
    
    @discardableResult
    private func startVision()-> UIViewController {
        let tabBarController = createTabBarController()
        tabBarController.showAsRoot()
        return tabBarController
    }
}

// MARK: - Main tab bar
extension MainCoordinator {
    
    fileprivate func tabBarItem(for coordinator: Coordinator)-> UITabBarItem {
        switch coordinator {
        case is VisionCoordinator:
            return .vision
        case is QuizCoordinator:
            return .quiz
        case is InfoCoordinator:
            return .info
        default:
            fatalError("No tab bar set for this coordinator!")
        }
    }
    
    fileprivate func createTabBarController()-> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let viewControllers = childCoordinators.map { coordinator-> UIViewController in
            let vc = coordinator.start()
            vc.tabBarItem = tabBarItem(for: coordinator)
            return vc
        }
        
        tabBarController.tabBar.unselectedItemTintColor = UIColor.darkBlue.withAlphaComponent(0.5)
        tabBarController.tabBar.tintColor = .darkBlue
        
        tabBarController.viewControllers = viewControllers
        
        return tabBarController
    }
    
}
