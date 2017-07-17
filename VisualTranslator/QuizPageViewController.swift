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
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        prepareQuestions()
        
        if let firstVC = questionViewControllers.first {
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            currentIndex += 1
        }
    }
    
    func prepareQuestions() {
        let questions = viewModel.getQuestions(language: viewModel.language, difficulty: viewModel.pickedDifficulty)
        
        print(questions)
        
        if viewModel.withImage {
            for question in questions {
                let vc = QuizWithPicturesViewController.instance()
                vc.question = question
                vc.onNextPage = { _ in
                    self.goToNextQuestion()
                }
                questionViewControllers.append(vc)
            }
        } else {
            for question in questions {
                let vc = QuizWithoutPicturesViewController.instance()
                vc.question = question
                vc.onNextPage = { _ in
                    self.goToNextQuestion()
                }
                questionViewControllers.append(vc)
            }
        }
    }
    
    func goToNextQuestion() {
        let vc = questionViewControllers[currentIndex]
        setViewControllers([vc],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        if currentIndex == questionViewControllers.count - 1 {
            //do something
        } else {
            currentIndex += 1
        }
    }
}
