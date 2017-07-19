//
//  QuizCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit


final class QuizCoordinator: NavCoordinator, Coordinator {
    
    private var navigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        let vc = MenuViewController.instance()
        let viewModel = MenuViewModel(persistenceService: serviceFactory.persistenceService)
        vc.viewModel = viewModel
        
        vc.viewModel.onGoToQuiz = { [weak self] image, difficulty in
            self?.showQuiz(withImage: image, difficulty: difficulty)
        }
        
        navigationController.viewControllers = [vc]
        vc.navigationBarDisplayMode = .always
        return navigationController
    }
    
    func showQuiz(withImage: Bool, difficulty: Difficulty) {
        navigationController.pushViewController(createQuiz(withImage: withImage, difficulty: difficulty), animated: true)
    }
    
    func createQuiz(withImage: Bool, difficulty: Difficulty) -> UIViewController {
        let viewController = QuizPageViewController.instance()
        let viewModel = QuizPageViewModel(pickedDifficulty: difficulty, withImage: withImage, persistenceService: serviceFactory.persistenceService)
        viewController.viewModel = viewModel
        
        viewController.viewModel.onGoToScore = { [weak self] in
            self?.showScore()
        }
        
        return viewController
    }
    
    func showScore() {
        navigationController.pushViewController(createScore(), animated: true)
    }
    
    func createScore() -> UIViewController {
        let viewController = ScoreViewController.instance()
        let viewModel = ScoreViewModel()
        viewController.viewModel = viewModel
        
        viewController.viewModel.onGoToMenu = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
        }
        
        return viewController
    }
}
