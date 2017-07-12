//
//  VisionCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 07/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

final class VisionCoordinator: NavCoordinator, Coordinator {
    
    private var navigationController = BaseNavigationController()
    
    func start() -> UIViewController {
        let vc = CameraViewController.instance()
        let viewModel = CameraViewModel(persistenceService: serviceFactory.persistenceService)
        vc.viewModel = viewModel
        
        viewModel.onGoToTranslation = { [weak self] image in
            self?.showTranslation(image: image)
        }
        
        viewModel.onGoToLanguage = { [weak self] in
            self?.showLanguagePicker()
        }
        
        navigationController.viewControllers = [vc]
        vc.navigationBarDisplayMode = .always
        return navigationController
    }
    
    func showTranslation(image: Data) {
        navigationController.pushViewController(createTranslation(image: image), animated: true)
    }
    
    func createTranslation(image: Data) -> UIViewController {
        let viewController = TranslationViewController.instance()
        let viewModel = TranslationViewModel(image: image)
        
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func showLanguagePicker() {
        
        let viewController = LanguageViewController.instance()
        
        let viewModel = LanguageViewModel(persistenceService: serviceFactory.persistenceService)
        viewController.viewModel = viewModel
        
        let languageController = BaseNavigationController()
        
        viewModel.onComplete = { _ in
            languageController.dismiss(animated: true)
        }
        
        languageController.viewControllers = [viewController]
        navigationController.present(languageController, animated: true)
    }
}
