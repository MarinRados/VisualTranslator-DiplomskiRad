//
//  QuizPageViewController.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

class QuizPageViewController: UIPageViewController {

    var viewModel: QuizPageViewModel!
    var questionViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        prepareQuestions()
        
        if let firstVC = questionViewControllers.first {
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func prepareQuestions() {
        let questions = viewModel.getQuestions(language: viewModel.language, difficulty: viewModel.pickedDifficulty)
        
        print(questions)
        
        if viewModel.withImage {
            for question in questions {
                let vc = QuizWithPicturesViewController.instance()
                vc.question = question
                questionViewControllers.append(vc)
            }
        } else {
            for question in questions {
                let vc = QuizWithoutPicturesViewController.instance()
                vc.question = question
                questionViewControllers.append(vc)
            }
        }
    }
}

extension QuizPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = questionViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = questionViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return questionViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
